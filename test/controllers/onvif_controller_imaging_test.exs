defmodule EvercamMedia.ONVIFControllerImagingTest do
  use EvercamMedia.ConnCase
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney, options: [clear_mock: true]

  @auth System.get_env["ONVIF_AUTH"]

  @moduletag :onvif
  @access_params "url=http://recorded_response&auth=#{@auth}"

  @tag :skip
  test "GET /v1/onvif/v20/DeviceIO/GetImagingSettings" do
    use_cassette "get_imaging_settings" do
      conn = get build_conn(), "/v1/onvif/v20/Imaging/GetImagingSettings?#{@access_params}&VideoSourceToken=VideoSource_1"
      brightness = json_response(conn, 200) |> Map.get("ImagingSettings") |> Map.get("Brightness")
      assert brightness == "50"
    end
  end

  @tag :skip
  test "GET /v1/onvif/v20/DeviceIO/GetServiceCapabilities" do
    use_cassette "img_get_service_capabilities" do
      conn = get build_conn(), "/v1/onvif/v20/Imaging/GetServiceCapabilities?#{@access_params}"
      image_stabilization = json_response(conn, 200) |> Map.get("Capabilities") |> Map.get("ImageStabilization")
      assert image_stabilization == "false"
    end
  end
end
