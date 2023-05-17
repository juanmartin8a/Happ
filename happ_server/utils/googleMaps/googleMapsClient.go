package googleMapsUtils

import (
	"happ/config"
	awsParameterStore "happ/utils/aws/awsParams"
	"log"

	"googlemaps.github.io/maps"
)

var GoogleMapsClient *maps.Client

func GetGoogleMapsClient() (*maps.Client, error) {

	APIKeyBytes, err := awsParameterStore.GetParamTypeSecretString(config.C.MapsAPIKey)
	if err != nil {
		log.Printf("error while getting google maps API key: %s", err)
		return nil, err
	}

	APIKey := string(APIKeyBytes)

	client, err := maps.NewClient(maps.WithAPIKey(APIKey))
	if err != nil {
		return nil, err
	}

	GoogleMapsClient = client

	return GoogleMapsClient, nil
}
