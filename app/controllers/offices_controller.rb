class OfficesController < ApplicationController
  before_action :set_office, only: [:show, :edit, :update, :destroy]

  def index
    @offices = Office.all
  end

  def show
    
  end
  
  def search
    if params['postcode'] == ''
      flash[:alert] = 'please enter a postcode'
      redirect_to offices_path
    else
      #get postcode string and take out any white space in the string
      postcode = params['postcode'].split(/\W/).join

      #use http to make a api request to get lat and long for postcode given
      #return error if non is passed
      @request = HTTP.get("http://api.postcodes.io/postcodes/#{postcode}")
      @response = JSON.parse(@request)

      if @response['status'] != 200
        flash[:notice] = 'postcode is invalid, please try again'
        redirect_to offices_path
      else
          #set long and lat in params based off values returned from api
        lon = @response['result']['longitude']
        lat = @response['result']['latitude']

        distance = params['distance'].to_i * 1.609344

        # divide distance in km by Radian of the earth in km (6371km)
        # this will speed up queries because we can calculate the min and max lon and lats with this data
        # now we don't have to perform the big formula bellow on all rows of the database but only on
        # the rows that are within the range of min and max lon and lat

        r = distance/6371

        latmin = lat - r 
        latmax = lat + r

        # here it gets a little more complicated, but calculating longitudes min and max the same way we did latitude
        # is incorrect because distance gets shorter the further north or south you go from the equator
        # so the next formula was taken from a math book to get the correct min/max long distance

        latT = Math.asin(Math.sin(lat)/Math.cos(r))

        # @longT = Math.acos( ( Math.cos(r) - Math.sin(latT) * Math.sin(lat) ) / ( Math.cos(latT) * Math.cos(lat) ) )
        # formula above is long form of formula bellow

        lonT = Math.asin(Math.sin(r)/Math.cos(lat))

        lonmin = lon - lonT
        lonmax = lon + lonT

        ## First attempt at creating query, but this query doesn't use index of the table so if we had a large dataset, searches would be slow
        #
        # sql = "select * from (
        # SELECT  *,( 3959 * acos( cos( radians(#{lat}) ) * cos( radians( lat ) ) * cos( radians( lon ) - radians(#{lon}) ) + sin( radians(#{lat}) # ) * sin( radians( lat ) ) ) ) AS distance 
        # FROM offices
        # ) al
        # where distance < #{params['distance']}
        # ORDER BY distance;"

        # This query uses indexes of the table and speeds up searches
        sql = "select * from (
        SELECT *,( lat >= #{latmin} AND lat <= #{latmax}) AND (lon >= #{lonmin} AND lon <= #{lonmax}),
        ( 3959 * acos( cos( radians(#{lat}) ) * cos( radians( lat ) ) * cos( radians( lon ) - radians(#{lon}) ) + sin( radians(#{lat}) ) * sin( radians( lat ) ) ) ) AS distance
        FROM offices
        ) al
        where distance < #{params['distance']}
        ORDER BY distance;"
        @office = ActiveRecord::Base.connection.execute(sql)
        
        # I tested this method with Postgis/rgeo method and they both return almost identical values
      end
      
    end
  end

  def new
    @office = Office.new
  end
  


  def edit
  end

  def create
    @office = Office.new(office_params)
    if @office.valid?
      get_coordinates
      capitalize_params
    end
    @office = Office.new(office_params)
    
    respond_to do |format|
      if @office.save
        format.html { redirect_to @office, notice: 'Office was successfully created.' }
        format.json { render :show, status: :created, location: @office }
      else
        format.html { render :new }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    get_coordinates
    capitalize_params
    respond_to do |format|
      if @office.update(office_params)
        format.html { redirect_to @office, notice: 'Office was successfully updated.' }
        format.json { render :show, status: :ok, location: @office }
      else
        format.html { render :edit }
        format.json { render json: @office.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @office.destroy
    respond_to do |format|
      format.html { redirect_to offices_url, notice: 'Office was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_office
      @office = Office.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def office_params
      params.require(:office).permit(:name, :country, :postcode, :street_ad, :town_city, :phone_no, :county, :lon, :lat)
    end
  
    def get_coordinates
    # dependicies, needs a valid params['office']['postcode'] value to work
    # get postcode string and take out any white space in the string
      
      postcode = params['office']['postcode'].split(/\W/).join
    
    #use http to make a api request to get lat and long for postcode given
    #return error if non is passed
    @request = HTTP.get("http://api.postcodes.io/postcodes/#{postcode}")
    @response = JSON.parse(@request)
    
    #set long and lat in params based off values returned from api
    params['office']['lon'] = @response['result']['longitude']
    params['office']['lat'] = @response['result']['latitude']
      
    end
  
  def capitalize_params
    params['office']['name'].capitalize!
    params['office']['postcode'].upcase! 
    params['office']['county'].capitalize! 
    params['office']['town_city'].capitalize! 
     
  end
end
