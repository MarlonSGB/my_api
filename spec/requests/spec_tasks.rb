require 'rails_helper'

describe 'TasksController', type: :request do
  context 'index' do
    it 'should return status ok' do
      get api_v1_tasks_path

      expect(response).to have_http_status(200)

    end

    it 'should return all tasks' do
      task = Task.create(title: 'Study Ruby', description: 'Watch Campus Code classes')
      other_task = Task.create(title: 'Do Homework', description: 'Read books and solve exercises')
      get '/api/v1/tasks'

      expect(response).to have_http_status(200)
      expect(response.body).to include task.title
      expect(response.body).to include task.description
      expect(response.body).to include other_task.title
      expect(response.body).to include other_task.description
    end
  end

  context 'show' do
    it 'should return a task' do
      task = Task.create(title: 'Study Ruby', description: 'Watch Campus Code classes')

      get api_v1_task_path(task)

      expect(response).to have_http_status(200)
      expect(response.body).to include task.title
      expect(response.body).to include task.description
    end

    it 'should return "not found" if task unavailable' do
      get api_v1_task_path(id:999)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'post' do
    it 'deve criar tarefa' do
      task = {task: {title: 'buy milk', description: 'buy milk on store'}}
      post api_v1_tasks_path, params: task
      expect(response).to have_http_status(201)
      expect(response.body).to include('buy milk')
      expect(response.body).to include('buy milk on store')
      expect(Task.last.title).to eq('buy milk')
    end
  end
end
