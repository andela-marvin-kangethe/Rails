class HomepageController < ApplicationController
  require 'json'
  require 'httparty'

  $id_container = Array.new

  def index
    # call_api
    @gallery = ArtImage.paginate(page: params[:page], per_page: 10).order('art_title ASC')
  end

  private

  def send_api_request
    response = HTTParty.get(
      "https://www.rijksmuseum.nl/api/en/collection?key=#{Figaro.env.RIJKS_STUDIO_API_KEY}&format=json&ps=50&p=7"
    )
    file = File.open("public/studio.json", "w")
    file.write(response.to_json)
  end

  def read_from_file
    data = JSON.parse(File.read('public/studio.json'))
    for images in data['artObjects']
      save_art_in_database(images)
      $id_container.push images["objectNumber"].downcase
    end  
  end

  def save_art_in_database(images)
    ArtImage.create(
      art_title: images["title"],
      image_url: images["webImage"]["url"],
      art_description: images["longTitle"],
      art_maker: images["principalOrFirstMaker"],
      art_id_number: images["objectNumber"]
    )
  end

  def send_api_request_for_description(art_id_number)
    response = HTTParty.get(
      "https://www.rijksmuseum.nl/api/en/collection/#{art_id_number}?key=#{Figaro.env.RIJKS_STUDIO_API_KEY}&format=json"
    )
    file = File.open('public/description.json', "w")
    file.write(response.to_json)
  end

  def read_description_from_json
    begin
      data = JSON.parse(File.read('public/description.json'))
      sleep 1
      data["artObject"]["description"]
    rescue Exception => e
      "everything is awesome"
    end  
  end

  def save_description
    for art_id in 0..$id_container.count-1
      send_api_request_for_description($id_container[art_id])
      sleep 3
      id_no = $id_container[art_id].upcase
      ArtImage.where(art_id_number: id_no).update(art_description: read_description_from_json)
    end  
    $id_container.clear  
  end

  def call_api
    send_api_request
    read_from_file
    # save_description
  end

  
end
