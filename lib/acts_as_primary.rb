module ActsAsPrimary

  def self.included base
    base.extend ClassMethods
  end

  def make_primary_for parent
    objects = self.class.to_s.downcase.pluralize
    parent.send(objects).each { |s| s.update_attribute 'primary_flag', false }
    update_attribute 'primary_flag', true
  end

  def primary?
    primary_flag
  end

  module ClassMethods
    def primary
      where('primary_flag = ?', true)[0]
    end
  end

end
