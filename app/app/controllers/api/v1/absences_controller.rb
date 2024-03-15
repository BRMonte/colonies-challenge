module Api
  module V1
    class AbsencesController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      before_action :set_studio, only: [:create]
      DATE_FORMAT = "%d/%m/%Y".freeze

      def index
        absences = Studio.absences
        render json: { absences: absences }, status: :ok
      end

      def create
        new_absences = Absence.new(@studio, params[:start_date], params[:end_date]).handle_stays

        if new_absences
            render json: { message: 'Stays were updated to insert absences.' }, status: :ok
        else
            render json: { error: 'No stays were updated.' }, status: :unprocessable_entity
        end
      end

      private

      def set_studio
        @studio = Studio.includes(:stays).find(params[:studio_id])
        return render json: { error: 'Studio not found' }, status: :not_found unless @studio
      end

      def absence_params
        params.require(:absence).permit(
          :studio_id,
          :start_date,
          :end_date
        ).merge(
          start_date: parse_date(params[:start_date]),
          end_date: parse_date(params[:end_date])
        )
      end

      def parse_date(date_string)
        Date.strptime(date_string, DATE_FORMAT)
      rescue ArgumentError
        nil
      end

      def record_not_found(exception)
        render json: { error: 'Studio could not found' }, status: :not_found
      end
    end
  end
end
