class BuildingsController < ApplicationController
    DEFAULT_LIMIT ||= 5

    skip_before_action :verify_authenticity_token

    def index
        @buildings = Building
            .includes(:custom_fields)
            .limit(DEFAULT_LIMIT)
            .offset((params[:page].to_i.clamp(1, Float::INFINITY) - 1) * DEFAULT_LIMIT)
            .order(created_at: :asc)
        render json: BuildingBlueprint.render(@buildings, root: :buildings, meta: { total: Building.count })
    end

    def create
        @building = Building.create_with_custom_fields(params)
        unless @building.errors.any?
            render json: BuildingBlueprint.render(@building)
        else
            render json: { errors: @building.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @building = Building.where(id: params[:id]).first
        return render json: { error: "Building #{params[:id]} not found" }, status: :not_found if @building.nil?
        @building.update_with_custom_fields(params)
        unless @building.errors.any?
            render json: BuildingBlueprint.render(@building)
        else
            render json: { errors: @building.errors.full_messages }, status: :unprocessable_entity
        end
    end
end
