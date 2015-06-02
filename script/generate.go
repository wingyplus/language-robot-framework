package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"
)

var url = "http://rfdocs.org/media/libraries/json/external/selenium2library-150.json"

type library struct {
	Keywords []*keyword `json:"keywords"`
}

type arguments string

func (args *arguments) argSnippet() []string {
	snipArgs := make([]string, 0, 0)
	if len(*args) == 0 {
		return snipArgs
	}

	for i, arg := range strings.Split(string(*args), ", ") {
		snipArgs = append(snipArgs, fmt.Sprintf("${%d:%s}", i+1, arg))
	}
	return snipArgs
}

func (args *arguments) String() string {
	return strings.Join(args.argSnippet(), "  ")
}

type keyword struct {
	Name string    `json:"name"`
	Args arguments `json:"arguments"`
}

func (k *keyword) String() string {
	return fmt.Sprintf(`  {
    text: '%s'
    snippet: '%s'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }`, k.Name, k.snipFunc())
}

func (k *keyword) snipFunc() string {
	args := k.Args.String()
	if len(args) == 0 {
		return k.Name
	}
	return fmt.Sprintf("%s  %s", k.Name, args)
}

func main() {
	resp, err := http.Get(url)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	var lib library
	if err := json.NewDecoder(resp.Body).Decode(&lib); err != nil {
		panic(err)
	}

	fmt.Println("module.exports = [")
	for _, k := range lib.Keywords {
		fmt.Println(k)
	}
	fmt.Println("]")
}
