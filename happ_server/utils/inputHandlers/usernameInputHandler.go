package inputHandlers

import (
	"strings"
	"unicode"
)

func IsValidCharacter(r rune) bool {
	return unicode.IsLetter(r) || unicode.IsNumber(r) || r == '.' || r == '_'
}

func ProcessString(input string) string {
	lowercase := strings.ToLower(input)
	noSpaces := strings.ReplaceAll(lowercase, " ", "")
	filtered := strings.Map(func(r rune) rune {
		if IsValidCharacter(r) {
			return r
		}
		return -1
	}, noSpaces)
	return filtered
}
