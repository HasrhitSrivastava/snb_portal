# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    totals = {
      total_student: Student.count,
      active_users: 1
    }

    sales_dataset = {
      labels: %w[Apr May Jun Jul Aug Sep],
      values: [ 1200, 1800, 2200, 1700, 2800, 2600 ]
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
