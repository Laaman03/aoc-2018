const fs = require('fs')
const readline = require('node:readline/promises')

const lineRe = /#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/

let width = 0
let height = 0
const fabrics = []

const rl = readline.createInterface({
	input: fs.createReadStream('input'),
	output: process.stdout,
})

rl.on('line', (line) => {
	const fabric = parseLine(line)
	width = Math.max(fabric.left + fabric.width, width)
	height = Math.max(fabric.down + fabric.height, height)
	fabrics.push(fabric)
})

rl.on('close', () => {
	fabric = Array.from(Array(height), () => Array.from(Array(width), ()=> []))
	for (let f of fabrics) {
		for (let i = f.down; i < f.down + f.height; i++) {
			for (let j = f.left; j < f.left + f.width; j++) {
				fabric[i][j].push(f.id)
			}
		}
	}
	const ids = new Set(fabrics.map(f => f.id))
	for (let row of fabric) {
		const double_counted = new Set(row.filter(cell => cell.length > 1).flat())
		for (id of double_counted) {
			ids.delete(id)
		}
	}
	console.log(ids)
})

function parseLine(line) {
	const matches = lineRe.exec(line)
	const [id, left, down, width, height] =
		matches.slice(1).map(n => parseInt(n, 10))
	return {
		id,
		left,
		down,
		width,
		height
	}
}

