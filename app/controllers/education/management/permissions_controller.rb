class Education::Management::PermissionsController <
  Education::Management::BaseController
  load_and_authorize_resource class: Education::Permission

  def create
    permissions_params.each do |id, value|
      permission = find_permission id
      return render_json t(".not_found"), 400 unless permission
      if permission.update_attributes optional: value.symbolize_keys
        next
      else
        return render_json t(".fail"), 400
      end
    end
    render_json t(".success"), 200
  end

  private

  def permissions_params
    JSON.parse params.require :permissions
  end

  def find_permission id
    Education::Permission.find_by id: id
  end
end
