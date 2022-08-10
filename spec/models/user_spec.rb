require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @another_user = FactoryBot.build(:user)
    @another_user.save
  end

  describe "ユーザー新規登録" do
    context "ユーザー新規登録できる時" do
      it "nicknameとemail、password、password_confirmation、last_name、first_name、last_name_spelling、first_name_spelling、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end
    context "ユーザー新規登録できない時" do
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在している場合、登録できない" do
        @user.email = @another_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end 
      it "emailに@が含まれていない場合、登録できない" do
        @user.email = "abcd1234efgh5678"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下では登録できない" do
        @user.password = "12345"
        @user.password_confirmation = "12345"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが129文字以上では登録できない" do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it "password_confirmationが空だと登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordとpassword_confirmationが不一致だと登録できない" do
        @user.password_confirmation = "1234abcd"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordは英字のみでは登録できない" do
        @user.password =  "abcdefgh"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角英数両方を含めて設定してください(全角不可)")
      end
      it "passwordは数字のみでは登録できない" do
        @user.password = "12345678"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角英数両方を含めて設定してください(全角不可)")
      end
      it "全角を含むパスワードでは登録できない" do
        @user.password = "123４ａbcd"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角英数両方を含めて設定してください(全角不可)")
      end
    
      it "last_nameが空だと登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "last_nameが半角だと登録できない" do
        @user.last_name = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name には全角文字を使用してください")
      end
      it "first_nameが空だと登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "first_nameが半角だと登録できない" do
        @user.first_name = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name には全角文字を使用してください")
      end
      it "last_name_spellingが空だと登録できない" do
        @user.last_name_spelling = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name spelling can't be blank")
      end
      it "last_name_spellingが半角だと登録できない" do
        @user.last_name_spelling = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name spelling には全角カタカナを使用してください")
      end
      it "first_name_spellingが空だと登録できない" do
        @user.first_name_spelling = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name spelling can't be blank")
      end
      it "first_name_spellingが半角だと登録できない" do
        @user.first_name_spelling = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name spelling には全角カタカナを使用してください")
      end
      it "birthdayが空だと登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
