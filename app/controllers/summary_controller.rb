class SummaryController < ApplicationController
  def index
    @records = Record.all
  end
end  