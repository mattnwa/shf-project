class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    edit?
  end

  def index?
    @user.admin? if @user
  end

  def update?
    @user.admin? ||  @record.user == @user
  end

  def edit?
    update?
  end

end
