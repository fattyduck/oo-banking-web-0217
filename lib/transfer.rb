class Transfer
  # your code here
  attr_reader :sender, :receiver, :amount, :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    return false if sender.balance < @amount
    sender.valid? && receiver.valid?
  end

  def transfer_money(sender, receiver, amount)
    sender.withdraw(amount)
    receiver.deposit(amount)
  end

  def execute_transaction
    if self.valid? && @status == "pending"
      transfer_money(@sender, @receiver, @amount)
      @status = "complete"
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      transfer_money(@receiver, @sender, @amount)
      @status = "reversed"
    end
  end
end
