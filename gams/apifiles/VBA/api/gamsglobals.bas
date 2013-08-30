Public Const maxdim As Integer = 19
Public Const str_len As Integer = 255
    
Public Const val_level As Integer = 0
Public Const val_marginal As Integer = 1
Public Const val_lower As Integer = 2
Public Const val_upper As Integer = 3
Public Const val_scale As Integer = 4
Public Const val_max As Integer = 4

Public Const sv_und As Integer = 0
Public Const sv_na As Integer = 1
Public Const sv_pin As Integer = 2
Public Const sv_min As Integer = 3
Public Const sv_leps As Integer = 4
Public Const sv_normal As Integer = 5
Public Const sv_acronym As Integer = 6
Public Const sv_max As Integer = 6

Public Const dt_set As Integer = 0
Public Const dt_par As Integer = 1
Public Const dt_var As Integer = 2
Public Const dt_equ As Integer = 3
Public Const dt_alias As Integer = 4
Public Const dt_max As Integer = 4

Public Const sv_valund As Double = 1E+300         ' undefined
Public Const sv_valna As Double = 2E+300          ' not available/applicable
Public Const sv_valpin As Double = 3E+300         ' plus infinity
Public Const sv_valmin As Double = 4E+300         ' minus infinity
Public Const sv_valeps As Double = 5E+300         ' epsilon
Public Const sv_valacronym As Double = 1E+301     ' potential/real acronym

Public Type string255
   s(255) As Byte
End Type

Public Type vbaptr
#If Win64 Then
    p As LongPtr
#Else
    p As Long
#End If
End Type
