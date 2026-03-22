import { ChemicalServer } from "chemicaljs";
import express from "express";
import fs from "fs";
import { execSync } from "child_process";
import chalk from "chalk";
import path from "path";
import { Request, Response } from "express";
import pages from "./src/pages.json";
import themes from "./src/themes.json";

const [app, listen] = new ChemicalServer();

const __dirname = path.resolve();

if (!fs.existsSync("build")) {
	console.log("No build found. Building...");
	execSync("npm run build");
	console.log("Built!");
}

const port = process.env.PORT || 8080;

app.use(express.static("build"));

app.serveChemical();

app.use((req: Request, res: Response) => {
	if (pages.includes(req.url)) {
		return res.sendFile(__dirname + "/build/index.html");
	} else {
		return res.status(404).sendFile(__dirname + "/build/index.html");
	}
});

const port = process.env.PORT || 8080;

listen(port, "0.0.0.0", () => {
  console.log(`Server running on port ${port}`);
});
