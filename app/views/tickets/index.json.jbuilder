json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :text, :project_id, :category_id, :closed, :closed_at, :status, :link, :attachment_id
  json.url ticket_url(ticket, format: :json)
end
