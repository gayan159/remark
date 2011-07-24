class ArticleSweeper < ActionController::Caching::Sweeper
  observe Article
  
  def after_create(article)
    expire_cache_for(article)
  end
  
  def after_update(article)
    expire_cache_for(article)
  end
  
  def after_destroy(article)
    expire_cache_for(article)
  end
  
  private
  def expire_cache_for(article)
    expire_action(:controller => '/blog', :action => 'index')
    expire_action(:controller => '/blog', :action => 'show', :day => article.published_at.strftime("%d"), :month => article.published_at.strftime("%m"), :year => article.published_at.strftime("%Y"), :permalink => article.permalink)
    
    expire_action(:controller => '/admin/articles', :action => 'index')
    expire_action(:controller => '/admin/articles', :action => 'edit', :id => article.id)
  end
end