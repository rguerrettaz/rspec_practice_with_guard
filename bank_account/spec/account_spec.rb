require "rspec"
 
require_relative "../account"
 
describe Account do

  let(:account_number) { '1234567890' }
  let(:starting_balance) { 50 }

  # let(:account_w_balance) { Account.new(account_number, starting_balance) }
  # let(:account_w_no_balance) { Account.new(account_number) }
  let(:account_new) { Account.new(account_number) }
  
  describe "#initialize" do
    it "takes an account number as an argument" do
      Account.new('1234567899').should be_instance_of Account
    end
    
    context "When the account number has more than 10 digits" do
      let(:account_number) { '12345678990' }
      it "should raise error" do
        expect { Account.new(account_number) }.to raise_error(InvalidAccountNumberError)
      end
    end

    context "When the account number has less than 10 digits" do
      let(:account_number) { '123456789' }
      it "should raise error" do
        expect { Account.new(account_number) }.to raise_error(InvalidAccountNumberError)
      end
    end
  end
 
  describe "#transactions" do
    context "when account not initialize with starting balance" do
      subject { Account.new( '1234567890')}
      its(:transactions) { should eq [0] }
    end

    context "when account is initialized with a balance" do
      subject { Account.new( '1234567890', 50) }
      its(:transactions) { should eq [50] }
    end
  end
 
  describe "#balance" do
    it "should return 0 if account created with no balance" do
      account_new.balance.should eq 0
    end
    
    it "should return 10 if we initialize with a 10 dollar starting balance" do
      test_account = Account.new('1234567899', 10)
      test_account.balance.should eq 10
    end
  end
 
  describe "#account_number" do
    it "should return the account number with first 6 digits hashed out" do
      account_new.acct_number.should eq '******7890'
    end
  end
 
  describe "deposit!" do
    it "should add a new transaction to transactions" do
      account_new.deposit!(10)
      account_new.transactions.last.should eq 10
    end

    it "should not allow for negative amounts to be deposited" do
      expect { account_new.deposit!(-5) }.to raise_error(NegativeDepositError)
    end

    it "should return the balance when called" do
      account_new.deposit!(10).should eq 10
    end
  end
 
  describe "#withdraw!" do
    
    it "should raise an OverdraftError if withdrawing more than balance" do
      expect {account_new.withdraw!(-30)}.to raise_error(OverdraftError)
    end

    it "should accept neg integers and append transactions" do
      account_new.deposit!(50)
      account_new.withdraw!(-30)
      account_new.transactions.last.should eq -30
    end

    it "should accept pos integers, turn them neg, and append to transactions" do
      account_new.deposit!(50)
      account_new.withdraw!(30)
      account_new.transactions.last.should eq -30
    end

    it "returns the balance after withdraw" do
      account_new.deposit!(50)
      account_new.withdraw!(30).should eq 20
    end
 
  end
end
