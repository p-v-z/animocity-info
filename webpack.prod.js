const merge = require('webpack-merge');
const base = require('./webpack.base.js');
const TerserPlugin = require('terser-webpack-plugin');
const S3Plugin = require('webpack-s3-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyPlugin = require('copy-webpack-plugin');

module.exports = merge(base, {
	mode: 'production',
	devtool: false,
	performance: {
		maxEntrypointSize: 900000,
		maxAssetSize: 900000,
	},
	optimization: {
		minimizer: [
			new TerserPlugin({
				terserOptions: {
					output: {
						comments: false,
					},
				},
			}),
		],
	},
	plugins: [
		new HtmlWebpackPlugin({
			filename: './index.html',
			template: './index.html',
			chunks: ['vendor', 'app'],
			chunksSortMode: 'manual',
			minify: {
				removeAttributeQuotes: false,
				collapseWhitespace: true,
				html5: true,
				minifyCSS: true,
				minifyJS: true,
				minifyURLs: true,
				removeComments: true,
				removeEmptyAttributes: true,
			},
			hash: false,
		}),
		new CopyPlugin([
			{ from: './404.html' },
			{ from: './humans.txt' },
			{ from: './robots.txt', to: './' }
		]),
		new S3Plugin({
			s3Options: {
				accessKeyId: process.env.AWS_ACCESS_KEY_ID,
				secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
				region: 'us-east-1',
			},
			s3UploadOptions: {
				Bucket: 'howmanysheepdoihave.com',
			},
		}),
	],
});
