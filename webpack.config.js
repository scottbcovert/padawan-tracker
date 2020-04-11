const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

module.exports = {
    mode: process.env.NODE_ENV,
    entry: {
        timeline: [
            './node_modules/timeline/dist/css/timeline.min.css',
            './node_modules/timeline/dist/images/arrow-left.svg',
            './node_modules/timeline/dist/images/arrow-right.svg'
        ].concat(
            process.env.NODE_ENV !== 'production'
                ? './node_modules/timeline/dist/js/timeline.min.js'
                : './node_modules/timeline/dist/js/timeline.prod.min.js'
        )
    },
    output: {
        filename: '[name].min.js',
        path: path.resolve(__dirname, 'force-app/core/staticresources/timeline')
    },
    module: {
        rules: [
            {
                test: /\.css$/,
                use: [MiniCssExtractPlugin.loader, 'css-loader']
            },
            {
                test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,
                use: ['svg-inline-loader']
            }
        ]
    },
    plugins: [
        new MiniCssExtractPlugin({
            filename: '[name].min.css'
        })
    ],
    resolve: {
        modules: ['node_modules']
    }
};
