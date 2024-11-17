class BuildingsController < ApplicationController
    MAX_LIMIT ||= 100
    DEFAULT_LIMIT ||= 10
    DEFAULT_OFFSET ||= 0

    skip_before_action :verify_authenticity_token

    def index
        @buildings = Building
            .includes(:custom_fields)
            .limit([ params.dig(:options, :limit).to_i, 100 ].min.nonzero? || 10)
            .offset(params.dig(:options, :offset).to_i || DEFAULT_OFFSET)
        render json: BuildingBlueprint.render(@buildings)
    end

    def create
        @building = Building.new(building_params)
        if @building.save
            render json: BuildingBlueprint.render(@building)
        else
            render json: { errors: @building.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @building = Building.where(id: params[:id]).first
        return render json: { error: "Building not found" }, status: :not_found if @building.nil?

        if @building.update(building_params)
            render json: BuildingBlueprint.render(@building)
        else
            render json: { errors: @building.errors.full_messages }
        end
    end

    private def building_params
        params.permit(:id, :address_line_1, :address_line_2, :city, :state, :zip, :client_id, { options: [ :limit, :offset ] })
    end
end
