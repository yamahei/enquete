require 'bundler'
Bundler.require


class SuperTable  < ActiveRecord::Base
    self.abstract_class = true

    DB_CONF = {
        adapter: "postgresql",
        host: "db",
        encoding: "utf-8",
        username: "postgres",#TODO: get from env
        password: "postgres",#TODO: get from env
        database: "myapp",#TODO: get from env
        pool: 3,
        timeout: 5000,
    }
    ActiveRecord::Base.establish_connection(DB_CONF)

end

# model_file_path = File.expand_path('../models/*.rb', __FILE__)
# Dir.glob(model_file_path).each do |file|
#     require file
# end

# class HogeView < SuperTable
#     def readonly?
#         true
#     end
# end


# --
# Enquete
# --
class Enquete < SuperTable
    # scope
    has_many :questions
    has_many :answers
end

# --
# Question
# --
class Question < SuperTable
    belongs_to :enquetes
    has_many :select_questions
    has_many :text_questions
    has_many :file_questions
end

class SelectQuestion < SuperTable
    belongs_to :questions
    has_many :select_options
end
class TextQuestion < SuperTable
    belongs_to :questions
    has_many :text_options
end
class FileQuestion < SuperTable
    belongs_to :questions
    has_many :file_options
end

class SelectOption < SuperTable
    belongs_to :select_questions
end
class TextOption < SuperTable
    belongs_to :text_questions
end
class FileOption < SuperTable
    belongs_to :file_questions
end

# --
# Answer
# --
class Answer < SuperTable
    belongs_to :enquetes
    has_many :answer_detail
end
class AnswerDetail < SuperTable
    belongs_to :answers
end
