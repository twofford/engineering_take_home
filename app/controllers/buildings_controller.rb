class BuildingsController < ApplicationController
    MAX_LIMIT ||= 100
    DEFAULT_LIMIT ||= 10
    DEFAULT_OFFSET ||= 0

    skip_before_action :verify_authenticity_token

    def index
        @buildings = Building
            .includes(:custom_fields)
            .limit([ params.dig(:options, :limit).to_i, 100 ].min.nonzero? || 10)
            .offset(params.dig(:options, :offset) || DEFAULT_OFFSET)
        render json: BuildingBlueprint.render(@buildings)
    end

    def create
    end

    def update
    end

    private def building_params
        params.permit(:address_line_1, :address_line_2, :state, :city, :zip, :client_id, :options)
    end
end
