VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisWorkbook"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub stocks():
'loops through all stocks in all worksheets and provides ticker, yearly change, percentage change and total volume
    For Each ws In Worksheets
    'Loop through each sheet
        lastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
        'find last row
        ws.Cells(1, 9).Value = "Ticker"
        ws.Cells(1, 10).Value = "Yearly Change"
        ws.Cells(1, 11).Value = "Percent Change"
        ws.Cells(1, 12).Value = "Total Stock Volume"
        'add the header information
        firstOpen = ws.Cells(2, 3).Value
        'define the opening value for the first row
        Dim ticker As Integer
        ticker = 2
        'establish index for each stock
        For i = 2 To lastRow:
            volume = volume + ws.Cells(i, 7).Value
            'add the volume each time
            If (ws.Cells(i, 1) <> ws.Cells(i + 1, 1)) Then
                'Check if the next cell is differnt from the current one
                'aka if this is the last cell of the ticker
                lastClose = ws.Cells(i, 5).Value
                'the last value of the stock
                Change = firstOpen - lastClose
                'the change from the start to end of year
                ws.Cells(ticker, 9) = ws.Cells(i, 1)
                'adds ticker name
                ws.Cells(ticker, 10) = Change
                If (ws.Cells(ticker, 10).Value < 0) Then
                    ws.Cells(ticker, 10).Interior.ColorIndex = 3
                Else
                    ws.Cells(ticker, 10).Interior.ColorIndex = 4
                End If
                'finding amount changed then format color
                ws.Cells(ticker, 11) = FormatPercent(Change / lastClose)
                'finding percent change
                ws.Cells(ticker, 12) = volume
                'adds the total volume for the stock
                firstOpen = ws.Cells(i + 1, 3)
                'defines the opening value for the next stock
                volume = 0
                'resets the volume to prep the new stock
                ticker = ticker + 1
                'increments ticker to the next index
            End If
        Next i
        'generate greatest increase volume and decrease values
        greatestIncrease = ws.Cells(2, 10).Value
        greatIncreaseTick = ws.Cells(2, 9).Value
        greatestDecrease = ws.Cells(2, 10).Value
        greatDecreaseTick = ws.Cells(2, 9).Value
        greatestVolume = ws.Cells(2, 12).Value
        greatVolTick = ws.Cells(2, 9).Value
        For j = 2 To ticker:
        'iterate through every ticker value if the value is greater/less
        'replace the ticker and value for the increase/decrease/volume
            If (ws.Cells(j, 10).Value > greatestIncrease) Then
                greatestIncrease = ws.Cells(j, 10).Value
                greatIncreaseTick = ws.Cells(j, 9).Value
            End If
            If (ws.Cells(j, 10).Value < greatestDecrease) Then
                greatestDecrease = ws.Cells(j, 10).Value
                greatDecreaseTick = ws.Cells(j, 9).Value
            End If
            If (ws.Cells(j, 12).Value > greatestVolume) Then
                greatestVolume = ws.Cells(j, 12).Value
                greatVolTick = ws.Cells(j, 9).Value
            End If
        Next j
        'place all text where required
        ws.Cells(2, 17).Value = greatestIncrease
        ws.Cells(2, 16).Value = greatIncreaseTick
        ws.Cells(2, 15).Value = "Greatest % increase"
        ws.Cells(3, 17).Value = greatestDecrease
        ws.Cells(3, 16).Value = greatDecreaseTick
        ws.Cells(3, 15).Value = "Greatest % decrease"
        ws.Cells(4, 17).Value = greatestVolume
        ws.Cells(4, 15).Value = "Greatest Volume"
        ws.Cells(4, 16).Value = greatVolTick
        
        
    Next ws
End Sub
