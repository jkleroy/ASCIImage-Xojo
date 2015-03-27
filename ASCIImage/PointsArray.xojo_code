#tag Class
Protected Class PointsArray
	#tag Method, Flags = &h0
		Sub Append(P As REALbasic.Point)
		  Points.Append P
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function toArray() As REALbasic.Point()
		  Return Points()
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected Points() As REALbasic.Point
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
End Class
#tag EndClass
