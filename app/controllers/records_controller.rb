class RecordsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action :require_permission, only: [:update, :edit]

  def redirect_to_back(default = records_path)
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end

  def require_permission
    if !current_user.try(:admin?) and current_user.id != @record.user_id
      redirect_to_back
      flash[:alert] = "You do not have permission to edit this record."
    end
  end
  
  # GET /records
  # GET /records.json
  def index
    @total_expenses = Record.sum("quantity*price")
    @total_revenue = 25000
    @budget_balance = @total_revenue - @total_expenses
    
    if params[:status] == "pending"
      @records = Record.pending
    elsif params[:status] == "reviewed"
      @records = Record.reviewed
    elsif params[:status] == "approved"
      @records = Record.approved      
    elsif params[:status] == "rejected"
      @records = Record.rejected
    else
      @records = Record.where.not(status: 3)
    end
    respond_to do |format|
      format.html
      format.csv { send_data Record.all.to_csv, filename: "ubc-chemecar-#{Date.today}.csv" }
    end
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id
    @record.status = 'pending'

    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.json { render :show, status: :created, location: @record }
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:item, :description, :price, :quantity, :part_number, :supplier, :link, :status, :category)
    end
end
