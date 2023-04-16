//
//  ViewController.swift
//  ChartsDemo
//
//  Created by Javier Rodríguez Gómez on 15/9/21.
//

import UIKit
import Charts
import TinyConstraints

class ViewController: UIViewController, ChartViewDelegate {
    
    lazy var lineChartView: LineChartView = { //crea el gráfico
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue //color de fondo
        
        chartView.rightAxis.enabled = false //quita el eje vertical de la derecha
        
        let yAxis = chartView.leftAxis //para personalizar el eje y de la izquierda
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false) //número de etiquetas
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelPosition = .bottom //personalizar eje x
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .systemBlue
        
        chartView.animate(xAxisDuration: 2.5) //animación al mostrar el gráfico
        
        return chartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lineChartView) //muestra el gráfico en la vista
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        setData()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
        // esta función creo que no es necesaria y no sé muy bien qué hace
    }
    
    func setData() { //configura los datos
        let set1 = LineChartDataSet(entries: yValues, label: "Subscribers") //definir datos tipo set
        
        set1.mode = .cubicBezier //tipo de línea: suavizada
        set1.drawCirclesEnabled = false //quita el símbolo de los datos
        set1.lineWidth = 3 //grosor de línea
        set1.setColor(.white) //color de línea
        set1.fillColor = .white //relleno bajo la línea
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true //para que rellene bajo la línea
        set1.drawHorizontalHighlightIndicatorEnabled = false //no muestra una línea horizontal en amarillo que indica el valor sobre el que pasas el dedo o ratón (hay otra en vertical)
        set1.highlightColor = .systemRed //color de la línea de resaltado de los datos
        
        let data = LineChartData(dataSet: set1) //coge el set en bruto de los datos y los pasa al formato del gráfico
        data.setDrawValues(false) //no muestra el valor de cada dato en la gráfica
        lineChartView.data = data //asigna los datos al chart
    }
    
    let yValues: [ChartDataEntry] = [ //son los valores a mostrar. Definidos como set, pero puedes ser de más tipos
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 7.0),
        ChartDataEntry(x: 3.0, y: 5.0),
        ChartDataEntry(x: 4.0, y: 10.0),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 6.0, y: 5.0),
        ChartDataEntry(x: 7.0, y: 7.0),
        ChartDataEntry(x: 8.0, y: 8.0),
        ChartDataEntry(x: 9.0, y: 12.0),
        ChartDataEntry(x: 10.0, y: 13.0),
        ChartDataEntry(x: 11.0, y: 5.0),
        ChartDataEntry(x: 12.0, y: 7.0),
        ChartDataEntry(x: 13.0, y: 3.0),
        ChartDataEntry(x: 14.0, y: 15.0),
        ChartDataEntry(x: 15.0, y: 6.0),
        ChartDataEntry(x: 16.0, y: 6.0),
        ChartDataEntry(x: 17.0, y: 7.0),
        ChartDataEntry(x: 18.0, y: 3.0),
        ChartDataEntry(x: 19.0, y: 10.0),
        ChartDataEntry(x: 20.0, y: 12.0),
        ChartDataEntry(x: 21.0, y: 15.0),
        ChartDataEntry(x: 22.0, y: 17.0),
        ChartDataEntry(x: 23.0, y: 15.0),
        ChartDataEntry(x: 24.0, y: 10.0),
        ChartDataEntry(x: 25.0, y: 10.0),
        ChartDataEntry(x: 26.0, y: 10.0),
        ChartDataEntry(x: 27.0, y: 17.0),
        ChartDataEntry(x: 28.0, y: 13.0),
        ChartDataEntry(x: 29.0, y: 20.0),
        ChartDataEntry(x: 30.0, y: 24.0),
        ChartDataEntry(x: 31.0, y: 25.0),
        ChartDataEntry(x: 32.0, y: 27.0),
        ChartDataEntry(x: 33.0, y: 25.0),
        ChartDataEntry(x: 34.0, y: 30.0),
        ChartDataEntry(x: 35.0, y: 55.0),
        ChartDataEntry(x: 36.0, y: 58.0),
        ChartDataEntry(x: 37.0, y: 40.0),
        ChartDataEntry(x: 38.0, y: 43.0),
        ChartDataEntry(x: 39.0, y: 53.0),
        ChartDataEntry(x: 40.0, y: 55.0)
    ]
    
}

