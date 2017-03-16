class CompaniesController < ApplicationController
  protect_from_forgery except: :create
  before_action :set_company, only: [:show, :update, :destroy]

  # GET /companies
  def index
    @companies = Company.all
    json_response(@companies)
  end

  # POST /companies
  def create
    @company = Company.create!(company_params)
    json_response(@company, :created)
  end

  # GET /companies/:id
  def show
    json_response(@company)
  end

  # PUT /companies/:id
  def update
    @company.update(company_params)
  end

  # DELETE /companies/:id
  def destroy
    @company.destroy
    head :no_content
  end

  private
  def company_params
    params.permit(:name)
  end

  def set_company
    @company = Company.find_by(id: params[:id])
    json_404("Company doesn't exist") if @company.nil?
  end
end
