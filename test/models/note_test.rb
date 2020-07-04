require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  setup do
    # Devise internal error was causing fixture issues
    @user = User.new(name: 'user', email: 'user@gmail.com', password: '1244566', encrypted_password: User.new.send(:password_digest, '1244566'))
    @user.save!(validate: false)
    @invalid_string = 'CSdcCKf7nQatr6oqg03vlOSD5yJ5Cp07moT00UFZQuTlKCjuY2sidTwXnyRGF1IepWxlaAyyYe1VkXrCxGwmqwI01IzpE58U8lYBC5xIFJwdjuxqhulCWRj4qdINjpHtMPj5ID1gWsWbvZylaiMw6WwCi3F49MZlsRDsJQegwSU5DlduB9lqpFRB8wTGTFogpnBNCGkhE68NFUD2CsOXLMTUp6NEmjD97wsuTs8f7QV9IiS8MtJmg9aAudiiim9Pg3lp2MFBMgvc88tU1rnoFcOv6Ztyqyh1xxsj8zP8CR5GVoYgps68HRU3j4WTgqNLyRR5uwUmRvMZlSR5IFCbwX12IA2id3XlnQAVoJVzRV7sB0cDTqaHHV6BPeBWf8wt0RiSrXunJVwrA4LkIpKZpXnlRQN5fCFSESwfvJjesFZM0GQz4HzFekGDNrbNoNNeM7bVdd1g2fPHGFRUzOqDLk5obR6ZAyyjM6hr6gUlJRBQXeCekg0I66eX0Co8ziiZ30vyHURu87yntMTJnbnX5o2WbgARoY4PyNwrT64RKkrnytCi1Hnt7pYG4wUgP9dEPpAyDZG6VBP4hrxDWMKF5HBuDHE6XxPjYNKefA9jyuBOZTfMvhrDuoesZcjva0Y5xuPt34qsru9Ta2Xd1OCrEzHmin8KQ4rcOA7fXNu3jGeLE09oAtP4w8Sr02vhnysEJDPVT1MisUi9PC9IzQEBFhfJ1Ej1ZTl8B0Xhzne8f7La3PBWoZApDkz5ibUPw0UZtErHi1JlQJsELRIXkZmATdNuehaV9fbzZ9mruG97QajdP8BsY2jmJxlOZnRgp2mtM6J7ez60yWYuBfa8BFS5kkyW1ir2iR1wjvDjrIX9tHeaYXhK1L69YkRt9YlEJlXGXnvkwfcUNCjvJXMh951cuy8KjpWG4l1oWDBmOi0CImb8x2xUC94T4sffQGMzJr31rtT68RmeIuD37sflyMfkLzYOJCPe95QZyUjF8JqI2JCklYnkvazUXypj4hgf'
    @valid_string = 'CSdcCKf7nQatr6oqg03vlOSD5yJ5Cp07moT00UFZQuTlKCjuY2sidTwXnyRGF1IepWxlaAyyYe1VkXrCxGwmqwI01IzpE58U8lYBC5xIFJwdjuxqhulCWRj4qdINjpHtMPj5ID1gWsWbvZylaiMw6WwCi3F49MZlsRDsJQegwSU5DlduB9lqpFRB8wTGTFogpnBNCGkhE68NFUD2CsOXLMTUp6NEmjD97wsuTs8f7QV9IiS8MtJmg9aAudiiim9Pg3lp2MFBMgvc88tU1rnoFcOv6Ztyqyh1xxsj8zP8CR5GVoYgps68HRU3j4WTgqNLyRR5uwUmRvMZlSR5IFCbwX12IA2id3XlnQAVoJVzRV7sB0cDTqaHHV6BPeBWf8wt0RiSrXunJVwrA4LkIpKZpXnlRQN5fCFSESwfvJjesFZM0GQz4HzFekGDNrbNoNNeM7bVdd1g2fPHGFRUzOqDLk5obR6ZAyyjM6hr6gUlJRBQXeCekg0I66eX0Co8ziiZ30vyHURu87yntMTJnbnX5o2WbgARoY4PyNwrT'
  end

  test 'Note cannot be created with subject longer than 30 chars' do
    assert_raise ActiveRecord::RecordInvalid do
      Note.create!(subject: @invalid_string, body: 'note', user_id: @user.id)
    end
  end

  test 'Note cannot be created with all blank fields' do
    assert_raise ActiveRecord::RecordInvalid do
      Note.create!(body: '', subject: '', user_id: @user.id)
    end
  end

  test 'Note cannot be created with body longer than 1000 chars' do
    assert_raise ActiveRecord::RecordInvalid do
      Note.create!(body: @invalid_string, subject: 'note', user_id: @user.id)
    end
  end

  test "A note with no subject will be given up to 30 characters of it's body as it's subject" do
    note = Note.create!(subject: '', body: @valid_string,user_id: @user.id)
    assert_equal note.subject.length, 30
    assert_equal note.subject, note.body[0..29]
  end

end
