class Project < KalibroClient::Entities::Processor::Project
  include KalibroRecord
  include HasOwner

  attr_writer :attributes

  def self.public_or_owned_by_user(user = nil)
    class_name = name+"Attributes"
    collection = class_name.constantize.where(public: true)
    collection += class_name.constantize.where(user_id: user.id, public: false) if user

    collection.map do |item|
      begin
        self.find(item.send(name.underscore+"_id"))
      rescue Likeno::Errors::RecordNotFound
        nil
      end
    end.compact
  end

  def self.latest(count = 1)
    all.sort { |one, another| another.id <=> one.id }.select { |project|
      attributes = project.attributes
      attributes && attributes.public
    }.first(count)
  end

  def attributes
    @attributes ||= ProjectAttributes.find_by_project_id(@id)
  end

  def destroy
    self.attributes.destroy unless self.attributes.nil?
    @attributes = nil
    super
  end
end
