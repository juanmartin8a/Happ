package utils

func RemoveIntDuplicates(s []int) []int {
	m := make(map[int]bool)
	unique := []int{}

	for _, item := range s {
		if _, ok := m[item]; !ok {
			m[item] = true
			unique = append(unique, item)
		}
	}

	return unique
}
