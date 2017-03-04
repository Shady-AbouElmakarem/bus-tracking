json.extract! report, :id, :uid, :body, :created_at, :updated_at
json.url report_url(report, format: :json)