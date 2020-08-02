class HomeController < ApplicationController
    def index
        @news = New.last
    end
end