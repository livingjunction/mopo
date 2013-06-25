namespace :mopo_mkk do
  task :category_position => :environment do
    Category.all.each do |c|
      unless c.position.present?
        c.position = c.id
        c.name = "Lp #{c.id}: #{c.name}"
        c.save
      end
    end
  end
end