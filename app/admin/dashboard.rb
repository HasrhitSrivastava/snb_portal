# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  # content title: proc { I18n.t("active_admin.dashboard") } do
  #   div class: "px-4 py-16 md:py-32 text-center m-auto max-w-3xl" do
  #     h2 "Welcome to ActiveAdmin", class: "text-base font-semibold leading-7 text-indigo-600 dark:text-indigo-500"
  #     para "This is the default page", class: "mt-2 text-3xl sm:text-4xl font-bold text-gray-900 dark:text-gray-200"
  #     para class: "mt-6 text-xl leading-8 text-gray-700 dark:text-gray-400" do
  #       text_node "To update the content, edit the"
  #       strong "app/admin/dashboard.rb"
  #       text_node "file to get started."
  #     end
  #   end
  # end

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Demo numbers (static or compute here)
    totals = {
      total_student: Student.count,
      active_users: 1
    }

    # Chart demo dataset (labels + values as simple arrays)
    sales_dataset = {
      labels: %w[Apr May Jun Jul Aug Sep],
      values: [ 4200, 5200, 4800, 6100, 7300, 6900 ]
    }

    users_dataset = {
      labels: %w[Apr May Jun Jul Aug Sep],
      values: [ 120, 150, 140, 180, 220, 200 ]
    }

    stats = {
      revenue: "$12,430",
      users: 1284,
      signups: 87,
      orders: 42
    }

    # simple chart example data
    chart_data = {
      labels: %w[Jan Feb Mar Apr May Jun],
      values: [ 4, 6, 3, 8, 10, 7 ]
    }

    render partial: "admin/dashboard/demo_dashboard",
           locals: { totals: totals, sales_dataset: sales_dataset, users_dataset: users_dataset, stats: stats, chart_data: chart_data }
  end
end
