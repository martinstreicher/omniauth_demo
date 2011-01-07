class User < ActiveRecord::Base
  SKILLS_QUESTIONS = '
    SELECT q.*
    FROM questions q, intents i, mappings m, topics t
    WHERE i.user_id=#{id} AND i.type="Skill" AND i.topic_id=t.id AND m.topic_id=t.id AND m.question_id=q.id'
  CONNECTIONS_QUESTIONS = SKILLS_QUESTIONS.gsub('Skill', 'Connection')
  INTERESTS_QUESTIONS = SKILLS_QUESTIONS.gsub('Skill', 'Interest')

  attr_accessor :connection_values, :interest_values, :skill_values

  devise :confirmable, :database_authenticatable, :omniauthable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :connections
  has_many :connections_questions, :class_name => 'Question', :finder_sql => CONNECTIONS_QUESTIONS
  has_many :endorsements, :through => :votes, :source =>  :question
  has_many :questions
  has_many :intents
  has_many :interests
  has_many :interests_questions, :class_name => 'Question', :finder_sql => INTERESTS_QUESTIONS
  has_many :skills
  has_many :skills_questions, :class_name => 'Question', :finder_sql => SKILLS_QUESTIONS
  has_many :votes

  after_save :set_intents
 
  def update_intents(intents = {})
    intents.each do |key, values_string|
      set_intent key.gsub('_values', ''), values_string
    end
  end
 
  private

    def set_intents
      [:connection, :interest, :skill].each do |intent|
        next if (values = self.send("#{intent}_values")).blank?
        set_intent intent, values
      end
    end

    def set_intent(intent, values)
      self.send("#{intent}s").map(&:destroy)
      values.split(',').map(&:strip).map(&:downcase).map do |topic_string|
        topic = Topic.find_or_create_by_name topic_string
        intent.to_s.capitalize.constantize.
          find_or_create_by_topic_id_and_user_id topic.id, self.id
      end
      self.reload
    end
end
