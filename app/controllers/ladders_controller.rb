class LaddersController < ApplicationController
  # GET /ladders
  # GET /ladders.xml
  def index
    @ladders = Ladder.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ladders }
    end
  end

  # GET /ladders/1
  # GET /ladders/1.xml
  def show
    @ladder = Ladder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ladder }
    end
  end

  # GET /ladders/new
  # GET /ladders/new.xml
  def new
    @ladder = Ladder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ladder }
    end
  end

  # GET /ladders/1/edit
  def edit
    @ladder = Ladder.find(params[:id])
  end

  # POST /ladders
  # POST /ladders.xml
  def create
    @ladder = Ladder.new(params[:ladder])

    respond_to do |format|
      if @ladder.save
        flash[:notice] = 'Ladder was successfully created.'
        format.html { redirect_to(@ladder) }
        format.xml  { render :xml => @ladder, :status => :created, :location => @ladder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ladder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ladders/1
  # PUT /ladders/1.xml
  def update
    @ladder = Ladder.find(params[:id])

    respond_to do |format|
      if @ladder.update_attributes(params[:ladder])
        flash[:notice] = 'Ladder was successfully updated.'
        format.html { redirect_to(@ladder) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ladder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ladders/1
  # DELETE /ladders/1.xml
  def destroy
    @ladder = Ladder.find(params[:id])
    @ladder.destroy

    respond_to do |format|
      format.html { redirect_to(ladders_url) }
      format.xml  { head :ok }
    end
  end
end
