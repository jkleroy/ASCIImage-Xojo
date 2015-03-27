#tag Module
Protected Module ASCIImage
	#tag Method, Flags = &h0
		Sub DrawASCIIRepresentation(extends g As Graphics, representation() As String, deltaX As Integer = 0, deltaY As Integer = 0, scale As Double = 1)
		  Dim shape As Group2D
		  
		  // Cleaning the input
		  representation = strictASCIIRepresentationFromLenientASCIIRepresentation(representation)
		  
		  // Retrieving all shapes
		  shape = shapesFromNumbersInStrictASCIIRepresentation(representation)
		  
		  
		  
		  shape.Border = 1
		  shape.BorderColor = &c0
		  shape.BorderWidth = 1
		  shape.Fill = 100
		  shape.FillColor = &c0
		  
		  shape.Scale = scale
		  
		  g.DrawObject(shape, deltaX, deltaY)
		  
		  //This is a second way of doing it
		  
		  'Dim i As Integer
		  ''
		  'Dim o As Object2D
		  '
		  'For i = 0 to Shape.Count-1
		  '
		  'o = Shape.Item(i)
		  '
		  'o.Scale = scale
		  '
		  'g.DrawObject(o, deltaX, deltaY)
		  '
		  'Next
		  
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function orderedMarksForASCIIShape() As String()
		  Dim numbers As String = "1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n p q r s t u v w x y z"
		  
		  Return numbers.Split(" ")
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function shapesFromNumbersInStrictASCIIRepresentation(representation() As String) As Group2D
		  // canvas size
		  Dim countRows As Integer = UBound(representation)+1
		  
		  If countRows = 0 then
		    Return Nil
		  End If
		  
		  Dim countCols As Integer = representation(0).Len
		  Dim countPixels As Integer = countRows*countCols
		  Dim asciiString As String = Join(representation, "")
		  
		  // collect positions of the different marks in the shape
		  Dim markPositions As New Dictionary
		  Dim mark As String
		  Dim positions As ASCIImage.PointsArray
		  Dim x, y, i As Integer
		  
		  For i = 0 to countPixels
		    
		    mark = asciiString.Mid(i+1, 1)
		    
		    //Xojo Dictionary isn't case sensitive. We virtually add this
		    if asc(mark)>=97 and asc(mark) <=122 then
		      mark = "*" + mark
		    end if
		    
		    If not markPositions.HasKey(mark) then
		      markPositions.Value(mark) = New PointsArray
		      positions = new PointsArray
		    else
		      positions = PointsArray(markPositions.Value(mark).ObjectValue)
		    End If
		    
		    
		    // new position: note that the Y need to be inverted to get the coordinate rights
		    x = i mod countCols
		    y = i / countCols
		    positions.Append new REALbasic.Point(x, y)
		    
		    markPositions.Value(mark) = positions
		    
		  Next
		  
		  // iterate over the possible marks (1, 2, 3, ...), building shapes as we go
		  Dim shapes As New Group2D
		  Dim marks() As String = orderedMarksForASCIIShape()
		  Dim currentPoints() As REALbasic.Point
		  Dim points() As REALbasic.Point
		  Dim numberOfPoints As Integer
		  
		  Dim FS As FigureShape2
		  For each mark in marks
		    
		    //Xojo Dictionary isn't case sensitive. We virtually add this
		    if asc(mark)>=97 and asc(mark) <=122 then
		      mark = "*" + mark
		    end if
		    
		    If not markPositions.HasKey(mark) then Continue
		    
		    points = PointsArray(markPositions.Value(mark).ObjectValue).toArray
		    numberOfPoints = UBound(points) + 1
		    
		    // continue current shape or start a new one
		    if numberOfPoints = 1 then
		      
		      currentPoints.Append points(0)
		      
		      If FS is Nil then
		        FS = New FigureShape2
		      end if
		      
		      FS.AppendPoint points(0)
		      
		      
		    Else
		      
		      //close current shape
		      If currentPoints <> Nil and UBound(currentPoints) > -1 then
		        shapes.Append FS
		        currentPoints = nil
		        FS = Nil
		      End If
		      
		      // single pixel
		      If numberOfPoints = 1 then
		        Dim r As New RectShape
		        r.Width = 2
		        r.Height = 2
		        r.X = points(0).X
		        r.Y = points(0).Y
		        shapes.Append r
		        
		        // line
		      Elseif numberOfPoints = 2 then
		        Dim f As new CurveShape
		        f.X = points(0).X
		        f.Y = points(0).Y
		        f.X2 = Points(1).X
		        f.Y2 = Points(1).Y
		        
		        'If f.X = f.X2 then
		        'f.Y = f.Y - 0.5
		        'f.Y2 = f.Y2 + 0.5
		        '
		        'end if
		        'If f.Y = f.Y2 then
		        'f.X = f.X - 0.5
		        'f.X2 = f.X2 + 0.5
		        'end if
		        
		        'f.Border = 0
		        
		        // Border is wider for non horizontal/vertical lines
		        If f.X <> f.X2 and f.Y <> f.Y2 then
		          f.BorderWidth = sqrt(2) 
		        end if
		        
		        f.Fill = 100
		        
		        'Dim f As new FigureShape
		        'f.AddLine(points(0).X, points(0).y, points(1).X, points(1).Y)
		        '
		        'f.AddLine(points(1).X, points(1).y, points(0).X, points(0).Y)
		        '
		        'f.Border = 100
		        shapes.Append f
		        
		        //ellipse
		      elseif numberOfPoints > 2 then
		        Dim w, h As Double
		        x = points(0).X
		        y = points(0).Y
		        
		        For i = 1 to UBound(points)
		          w = max(w, points(i).X - x)
		          h = max(h, points(i).Y - y)
		          
		          x = min(x, points(i).X)
		          y = min(y, points(i).Y)
		        Next
		        
		        Dim o as new OvalShape
		        o.Width = w+1
		        o.Height = h+1
		        o.X = X-0.5 + w/2.0
		        o.Y = Y-0.5 + h/2.0
		        
		        'o.Width = w
		        'o.Height = h
		        'o.X = X-0.5 + w/2.0
		        'o.Y = Y-0.5 + h/2.0
		        'o.Border = 100
		        shapes.Append o
		      End If
		    end if
		  Next
		  
		  If currentPoints <> Nil and UBound(currentPoints) > -1 then
		    shapes.Append FS
		    currentPoints = nil
		    FS = Nil
		  End If
		  
		  
		  Return shapes
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function strictASCIIRepresentationFromLenientASCIIRepresentation(lenientRep() As String) As String()
		  Dim u As Integer = UBound(lenientRep)
		  Dim i As Integer
		  
		  //empty input
		  If u = -1 then
		    System.DebugLog(CurrentMethodName + " ERROR: empty ASCII shape")
		    Return Nil
		  End If
		  
		  
		  
		  //empty lines
		  Dim columnCount As Integer
		  
		  columnCount = lenientRep(0).Len
		  If columnCount = 0 then
		    System.DebugLog(CurrentMethodName + " ERROR: empty lines in ASCII shape")
		  End If
		  
		  //consistent data?
		  For i = 1 to u
		    If columnCount <> lenientRep(i).Len then
		      System.DebugLog(CurrentMethodName + " ERROR: inconsistent line sizes in ASCII shape")
		      Return Nil
		    End If
		  Next
		  
		  //remove whitespace
		  For i = 0 to u
		    lenientRep(i) = lenientRep(i).ReplaceAll(" ", "").ReplaceAll(chr(9), "")
		  Next
		  
		  Return lenientRep()
		  
		  
		  
		  //Don't really understand what the below code is for.
		  '
		  '
		  '// detect "pixels" = non-space characters
		  'Dim pixelColumns() As Integer
		  'Dim newLocation As Integer
		  'Dim char As String
		  'For i = 1 to total
		  'char = concatenatedStrings.Mid(i, 1)
		  'If markCharactersForASCIIShape.InStr(char)>0 then
		  'pixelColumns.Append i mod columnCount
		  'End If
		  'Next
		  '
		  'pixelColumns.Sort()
		  '
		  '// gaps between pixels
		  'Dim gaps() As Integer
		  'Dim firstColumn As Integer = pixelColumns(0)
		  'Dim currentColumn As Integer = firstColumn
		  'Dim nextColumn As Integer
		  'For i = 1 to UBound(pixelColumns)
		  'nextColumn = pixelColumns(i)
		  '
		  'gaps.Append nextColumn-currentColumn
		  '
		  'currentColumn = nextColumn
		  'Next
		  '
		  'gaps.Sort()
		  '
		  '// pixels should be regularly spaced: the actual gap is the greater common divisor
		  '// no need to make that a fancy algorithm, let's just enumerate all possible values going down, and including, the smallest gap
		  'Dim smallestGap As Integer
		  'If UBound(gaps) > -1 then
		  'smallestGap = gaps(0)
		  'else
		  'smallestGap = 1
		  'End If
		  'Dim gap As Integer
		  'Dim pixelGap As Integer = 1
		  'Dim idx As Integer
		  'For i = smallestGap DownTo 1
		  '
		  'If UBound(gaps)>-1
		  'gap = gaps(0)
		  'while 
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		PARColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		PARImage As Picture
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PARColor"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PARImage"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
