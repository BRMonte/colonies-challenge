module Api
  module V1
    class AbsencesController < ActionController::API
      def index
        absences = Studio.absences
        render json: { absences: absences }, status: :ok
      end
    end
  end
end
