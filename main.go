package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/gen2brain/go-fitz"
)

func main() {

	inputFile := flag.String("i", "", "Input PDF file path")
	outputFile := flag.String("o", "", "Output image file path")
	quality := flag.Float64("q", 250, "Image quality")

	// Parse command-line arguments
	flag.Parse()

	// Validate required flags
	if *inputFile == "" || *outputFile == "" {
		fmt.Println("Error: Input and output file paths are required.")
		return
	}

	// Simulate PDF to image conversion
	fmt.Printf("Converting %s to %s with quality %f...\n", *inputFile, *outputFile, *quality)
	// Add your PDF to image conversion logic here

	fmt.Println("Conversion completed successfully!")

	doc, err := fitz.New(*inputFile)

	if err != nil {
		panic(err)
	}

	img, err := doc.ImagePNG(0, *quality)
	if err != nil {
		panic(err)
	}

	err = os.WriteFile(*outputFile, img, os.ModeAppend)

	if err != nil {
		panic(err)
	}

}
