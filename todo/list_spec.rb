require "rspec"
 
require_relative "list"
require_relative "task"
 
describe List do
  before(:each) do
    @task1 = stub(:task1, :description => "yay", :complete => false)
    @task2 = stub(:task2, :description => "yay2", :complete => true)
  end

  let(:title) { "Grocery Store"}
  let(:tasks) { [@task1, @task2] } 
  let(:list)  { List.new(title, tasks) }
  describe "#initialize" do
    it "takes a title and list of tasks as arguments" do
      List.new("Grocery List", []).should be_instance_of List
    end

    it "can't have zero arguments" do
      expect { List.new }.to raise_error(ArgumentError)
    end
  end

  describe "#title" do
    it "returns the correct titlef or the task" do
      list.title.should eq title
    end
  end

  describe "#tasks" do
    it "returns the correct titlef or the task" do
      list.tasks.should eq tasks
    end
  end

  describe "#add task" do
    it "should add a task to tasks" do
      @task3 = stub(:task1, :description  => "yay3", :complete => true)
      list.add_task(@task3)
      tasks.length.should eq 3
    end
  end

  describe "#complete task" do
    it "should update task.complete" do
      @task1.stub(:complete!).and_return(true)
      response = tasks[0].complete!
      response.should be(true)
    end
  end

  describe "#delete task" do
    it "should delete a task from tasks" do
      list.delete_task(2)
      tasks.length.should eq 2
    end
  end

  describe "#completed task" do
    it "should show all tasks where task.complete eq true" do
      @task1.stub(:complete?).and_return(true)
      @task2.stub(:complete?).and_return(true)
      completed = list.completed_tasks
      completed.should match_array([@task1, @task2])   
    end
  end

  describe "#incomplete task" do
    it "should show all tasks where task.complete eq false" do
      @task1.stub(:complete?).and_return(false)
      @task2.stub(:complete?).and_return(false)
      completed = list.incomplete_tasks
      completed.should match_array([@task1, @task2]) 
    end
  end

end
