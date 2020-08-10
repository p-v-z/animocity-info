const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyPlugin = require('copy-webpack-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const RobotstxtPlugin = require("robotstxt-webpack-plugin");


module.exports = {
	entry: {
		app: [path.resolve(__dirname, 'src/main.js')]
	},
	mode: "production",
	module: {
		rules: [
			{
				test: /\.js$/,
				exclude: /node_modules/,
				use: {
					loader: 'babel-loader',
				},
			},
			{
				test: [/\.vert$/, /\.frag$/],
				use: 'raw-loader',
			},
			{
				test: /\.(gif|png|jpe?g|svg|xml)$/i,
				use: 'file-loader',
			},
			{
				test: /\.s[ac]ss$/i,
				use: [
					// Creates `style` nodes from JS strings
					'style-loader',
					// Translates CSS into CommonJS
					'css-loader',
					// Compiles Sass to CSS
					'sass-loader'
				],
			},
			{
				test: /\.mp4$/,
				use: 'file-loader?name=videos/[name].[ext]',
		 	}
		],
	},
	plugins: [
		new CleanWebpackPlugin({
			root: path.resolve(__dirname, '../'),
		}),
		new HtmlWebpackPlugin({
			template: './index.html',
			favicon: './favicon.ico',
			
		}),
		new CopyPlugin({
			patterns: [
				{ from: 'assets', to: 'assets' },
				{ from: 'robots.txt', to: 'assets' },
			]
		}),
		new RobotstxtPlugin({filePath: './robots.txt'})
	]
};
