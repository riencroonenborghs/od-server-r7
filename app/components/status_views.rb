module StatusViews
  def queued_view?
    @status_views.include?(:queued)
  end

  def started_view?
    @status_views.include?(:started)
  end

  def finished_view?
    @status_views.include?(:finished)
  end

  def cancelled_view?
    @status_views.include?(:cancelled)
  end

  def failed_view?
    @status_views.include?(:failed)
  end
end