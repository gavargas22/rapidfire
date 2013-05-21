require 'spec_helper'

describe Rapidfire::Questions::Date do
  describe "validate_answer" do
    let(:question)  { FactoryGirl.create(:q_date, validation_rules: validation_rules) }
    let(:answer)    { FactoryGirl.build(:answer, question: question, answer_text: answer_text) }
    before(:each)   { answer.valid? }

    context "when there are no validation rules" do
      let(:validation_rules) { {} }
      let(:answer_text)      { "" }

      it "answer should pass validations" do
        answer.errors.should be_empty
      end

      context "when there is an answer" do
        context "when answer is valid date" do
          let(:answer_text)   { Date.today.to_s }

          it "passes validation" do
            answer.errors.should be_empty
          end
        end

        context "when answer is invalid date" do
          let(:answer_text)   { "sample answer" }

          it "fails validation" do
            answer.errors.should_not be_empty
          end

          it "says answer is invalid" do
            answer.errors[:answer_text].should include("is invalid")
          end
        end
      end
    end

    context "when question should have an answer" do
      let(:validation_rules) { { presence: true } }

      context "when answer is empty" do
        let(:answer_text)  { "" }

        it "fails validations" do
          answer.errors.should_not be_empty
        end

        it "says answer should be present" do
          answer.errors[:answer_text].should include("can't be blank")
        end
      end

      context "when answer is not empty" do
        context "when answer is valid date" do
          let(:answer_text)   { Date.today.to_s }

          it "passes validation" do
            answer.errors.should be_empty
          end
        end

        context "when answer is invalid date" do
          let(:answer_text)   { "sample answer" }

          it "fails validation" do
            answer.errors.should_not be_empty
          end

          it "says answer is invalid" do
            answer.errors[:answer_text].should include("is invalid")
          end
        end
      end
    end
  end
end
