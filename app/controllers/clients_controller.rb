class ClientsController < ApplicationController
  def index
    @clients = Client.all
    render json: ClientBlueprint.render(@clients, root: :clients, meta: { total: Client.count })
  end
end
