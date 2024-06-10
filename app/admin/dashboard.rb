ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    columns do
      column do
        panel 'Admin Info' do
          # para "Number of Breeds #{Breed.all.count}"
          # para "Number of Gardens #{Garden.all.count}"
          # para "Number of Trees #{Tree.all.count}"
          para "Number of Community Area #{CommunityArea.all.count}"
        end
      end
    end

  end # content
end
