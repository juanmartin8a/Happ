package googleMapsUtils

import (
	"context"
	"happ/graph/model"
	"log"

	"googlemaps.github.io/maps"
)

func LocationAutocomplete(ctx context.Context, search string) (*[]maps.AutocompletePrediction, error) {
	request := maps.PlaceAutocompleteRequest{
		Input: search,
	}

	res, err := GoogleMapsClient.PlaceAutocomplete(ctx, &request)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	return &res.Predictions, nil
}

func LocationDetails(ctx context.Context, placeID string) (*[]maps.GeocodingResult, error) {
	request := maps.GeocodingRequest{
		PlaceID: placeID,
	}

	res, err := GoogleMapsClient.ReverseGeocode(ctx, &request)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	return &res, nil
}

func LocationDetailsFromCoords(ctx context.Context, coords model.CoordinatesInput) (*[]maps.GeocodingResult, error) {
	request := maps.GeocodingRequest{
		LatLng: &maps.LatLng{
			Lat: coords.Latitude,
			Lng: coords.Longitude,
		},
	}

	res, err := GoogleMapsClient.ReverseGeocode(ctx, &request)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	return &res, nil
}
