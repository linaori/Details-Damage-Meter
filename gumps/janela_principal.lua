
--note: this file need a major clean up especially on function creation.

local _detalhes = 		_G._detalhes
local Loc = LibStub ("AceLocale-3.0"):GetLocale ( "Details" )
local _
local gump = 			_detalhes.gump
local SharedMedia = LibStub:GetLibrary ("LibSharedMedia-3.0")

local atributos = _detalhes.atributos
local sub_atributos = _detalhes.sub_atributos
local segmentos = _detalhes.segmentos

--lua locals
local _cstr = tostring
local _math_ceil = math.ceil
local _math_floor = math.floor
local _ipairs = ipairs
local _pairs = pairs
local _string_lower = string.lower
local _unpack = unpack
--api locals
local CreateFrame = CreateFrame
local _GetTime = GetTime
local _GetCursorPosition = GetCursorPosition
local _GameTooltip = GameTooltip
local _UIParent = UIParent
local _GetScreenWidth = GetScreenWidth
local _GetScreenHeight = GetScreenHeight
local _IsAltKeyDown = IsAltKeyDown
local _IsShiftKeyDown = IsShiftKeyDown
local _IsControlKeyDown = IsControlKeyDown
local modo_raid = _detalhes._detalhes_props["MODO_RAID"]
local modo_alone = _detalhes._detalhes_props["MODO_ALONE"]
local modo_grupo = _detalhes._detalhes_props["MODO_GROUP"]
local modo_all = _detalhes._detalhes_props["MODO_ALL"]

local gump_fundo_backdrop = {
	bgFile = [[Interface\AddOns\Details\images\background]], tile = true, tileSize = 16,
	insets = {left = 0, right = 0, top = 0, bottom = 0}}

function  _detalhes:ScheduleUpdate (instancia)
	instancia.barraS = {nil, nil}
	instancia.update = true
	if (instancia.showing) then
		instancia.atributo = instancia.atributo or 1
		
		if (not instancia.showing [instancia.atributo]) then --> unknow very rare bug where showing transforms into a clean table
			instancia.showing = _detalhes.tabela_vigente
		end
		
		instancia.showing [instancia.atributo].need_refresh = true
	end
end

--> skins TCoords

--	0.00048828125
	
	local DEFAULT_SKIN = [[Interface\AddOns\Details\images\skins\default_skin]]
	
	--local COORDS_LEFT_BALL = {0.15673828125, 0.27978515625, 0.08251953125, 0.20556640625} -- 160 84 287 211 (updated)
	--160 84 287 211
	local COORDS_LEFT_BALL = {0.15576171875, 0.27978515625, 0.08251953125, 0.20556640625} -- 160 84 287 211 (updated)
	
	local COORDS_LEFT_CONNECTOR = {0.29541015625, 0.30126953125, 0.08251953125, 0.20556640625} --302 84 309 211 (updated)
	local COORDS_LEFT_CONNECTOR_NO_ICON = {0.58837890625, 0.59423828125, 0.08251953125, 0.20556640625} -- 602 84 609 211 (updated)
	local COORDS_TOP_BACKGROUND = {0.15673828125, 0.65478515625, 0.22314453125, 0.34619140625} -- 160 228 671 355 (updated)
	
	--local COORDS_RIGHT_BALL = {0.31591796875, 0.43994140625, 0.08251953125, 0.20556640625} --324 84 451 211 (updated)
	local COORDS_RIGHT_BALL = {0.3154296875+0.00048828125, 0.439453125+0.00048828125, 0.08203125, 0.2060546875-0.00048828125} --323 84 450 211 (updated)
	
	--local COORDS_LEFT_BALL_NO_ICON = {0.44970703125, 0.57275390625, 0.08251953125, 0.20556640625} --460 84 587 211 (updated)
	local COORDS_LEFT_BALL_NO_ICON = {0.44970703125, 0.57275390625, 0.08251953125, 0.20556640625} --460 84 587 211 (updated) 588 212

	local COORDS_LEFT_SIDE_BAR = {0.76611328125, 0.82763671875, 0.00244140625, 0.50146484375} -- 784 2 848 514 (updated)
	--local COORDS_LEFT_SIDE_BAR = {0.76611328125, 0.82666015625, 0.00244140625, 0.50048828125} -- 784 2 848 514 (updated)
	--local COORDS_LEFT_SIDE_BAR = {0.765625, 0.8291015625, 0.00244140625, 0.5029296875} -- 784 2 848 514 (updated)
	--784 2 847 513
	
	--local COORDS_RIGHT_SIDE_BAR = {0.70068359375, 0.76220703125, 0.00244140625, 0.50146484375} -- 717 2 781 514 (updated)
	--local COORDS_RIGHT_SIDE_BAR = {0.7001953125, 0.763671875, 0.00244140625, 0.50146484375} -- 717 2 781 514 (updated)
	local COORDS_RIGHT_SIDE_BAR = {0.7001953125+0.00048828125, 0.76171875, 0.001953125, 0.5009765625} -- --717 2 780 513
	
	local COORDS_BOTTOM_SIDE_BAR = {0.32861328125, 0.82666015625, 0.50537109375, 0.56494140625} -- 336 517 847 579 (updated)
	
	local COORDS_SLIDER_TOP = {0.00146484375, 0.03076171875, 0.00244140625, 0.03173828125} -- 1 2 32 33 -ok
	local COORDS_SLIDER_MIDDLE = {0.00146484375, 0.03076171875, 0.03955078125, 0.10009765625} -- 1 40 32 103 -ok
	local COORDS_SLIDER_DOWN = {0.00146484375, 0.03076171875, 0.10986328125, 0.13916015625} -- 1 112 32 143 -ok

	local COORDS_STRETCH = {0.00146484375, 0.03076171875, 0.21435546875, 0.22802734375} -- 1 219 32 234 -ok
	local COORDS_RESIZE_RIGHT = {0.00146484375, 0.01513671875, 0.24560546875, 0.25927734375} -- 1 251 16 266 -ok
	local COORDS_RESIZE_LEFT = {0.02001953125, 0.03173828125, 0.24560546875, 0.25927734375} -- 20 251 33 266 -ok
	
	local COORDS_UNLOCK_BUTTON = {0.00146484375, 0.01513671875, 0.27197265625, 0.28564453125} -- 1 278 16 293 -ok
	
	local COORDS_BOTTOM_BACKGROUND = {0.15673828125, 0.65478515625, 0.35400390625, 0.47705078125} -- 160 362 671 489 -ok
	local COORDS_PIN_LEFT = {0.00146484375, 0.03076171875, 0.30126953125, 0.33056640625} -- 1 308 32 339 -ok
	local COORDS_PIN_RIGHT = {0.03564453125, 0.06494140625, 0.30126953125, 0.33056640625} -- 36 308 67 339 -ok
	
	-- icones: 365 = 0.35693359375 // 397 = 0.38720703125
	
function _detalhes:AtualizarScrollBar (x)

	local cabe = self.rows_fit_in_window --> quantas barras cabem na janela

	if (not self.barraS[1]) then --primeira vez que as barras est�o aparecendo
		self.barraS[1] = 1 --primeira barra
		if (cabe < x) then --se a quantidade a ser mostrada for maior que o que pode ser mostrado
			self.barraS[2] = cabe -- B = o que pode ser mostrado
		else
			self.barraS[2] = x -- contr�rio B = o que esta sendo mostrado
		end
	end
	
	if (not self.rolagem) then
		if (x > cabe) then --> Ligar a ScrollBar
			self.rows_showing = x
			
			if (not self.baseframe.isStretching) then
				self:MostrarScrollBar()
			end
			self.need_rolagem = true
			
			self.barraS[2] = cabe --> B � o total que cabe na barra
		else --> Do contr�rio B � o total de barras
			self.rows_showing = x
			self.barraS[2] = x
		end
	else
		if (x > self.rows_showing) then --> tem mais barras mostrando agora do que na �ltima atualiza��o
			self.rows_showing = x
			local nao_mostradas = self.rows_showing - self.rows_fit_in_window
			local slider_height = nao_mostradas*self.row_height
			self.scroll.scrollMax = slider_height
			self.scroll:SetMinMaxValues (0, slider_height)
			
		else	--> diminuiu a quantidade, acontece depois de uma coleta de lixo
			self.rows_showing = x
			local nao_mostradas = self.rows_showing - self.rows_fit_in_window
			
			if (nao_mostradas < 1) then  --> se estiver mostrando menos do que realmente cabe n�o precisa scrollbar
				self:EsconderScrollBar()
			else
				--> contr�rio, basta atualizar o tamanho da scroll
				local slider_height = nao_mostradas*self.row_height
				self.scroll.scrollMax = slider_height
				self.scroll:SetMinMaxValues (0, slider_height)
			end
			
		end
	end
	
	if (self.update) then 
		self.update = false
		self.v_barras = true
		return _detalhes:EsconderBarrasNaoUsadas (self)
	end
end

--> self � a janela das barras
local function move_barras (self, elapsed)
	self._move_func.time = self._move_func.time+elapsed
	if (self._move_func.time > 0.01) then
		if (self._move_func.instancia.bgdisplay_loc == self._move_func._end) then --> se o tamanho atual � igual ao final declarado
			self:SetScript ("OnUpdate", nil)
			self._move_func = nil
		else
			self._move_func.time = 0
			self._move_func.instancia.bgdisplay_loc = self._move_func.instancia.bgdisplay_loc + self._move_func.inc --> inc � -1 ou 1 e ir� crescer ou diminuir a janela
			
			for index = 1, self._move_func.instancia.rows_fit_in_window do
				self._move_func.instancia.barras [index]:SetWidth (self:GetWidth()+self._move_func.instancia.bgdisplay_loc-3)
			end
			self._move_func.instancia.bgdisplay:SetPoint ("bottomright", self, "bottomright", self._move_func.instancia.bgdisplay_loc, 0)
			
			self._move_func.instancia.bar_mod = self._move_func.instancia.bgdisplay_loc+(-3)
			
			--> verifica o tamanho do text
			for i  = 1, #self._move_func.instancia.barras do
				local esta_barra = self._move_func.instancia.barras [i]
				_detalhes:name_space (esta_barra)
			end
		end
	end
end

--> self � a inst�ncia
function _detalhes:MoveBarrasTo (destino)
	local janela = self.baseframe

	janela._move_func = {
		window = self.baseframe,
		instancia = self,
		time = 0
	}
	
	if (destino > self.bgdisplay_loc) then
		janela._move_func.inc = 1
	else
		janela._move_func.inc = -1
	end
	janela._move_func._end = destino
	janela:SetScript ("OnUpdate", move_barras)
end

function _detalhes:MostrarScrollBar (sem_animacao)

	if (self.rolagem) then
		return
	end
	
	if (not _detalhes.use_scroll) then
		self.baseframe:EnableMouseWheel (true)
		self.scroll:Enable()
		self.scroll:SetValue (0)
		self.rolagem = true
		return
	end

	local main = self.baseframe
	local mover_para = self.largura_scroll*-1
	
	if (not sem_animacao and _detalhes.animate_scroll) then
		self:MoveBarrasTo (mover_para)
	else
		--> set size of rows
		for index = 1, self.rows_fit_in_window do
			self.barras [index]:SetWidth (self.baseframe:GetWidth()+mover_para -3) --> -3 distance between row end and scroll start
		end
		--> move the semi-background to the left (which moves the scroll)
		self.bgdisplay:SetPoint ("bottomright", self.baseframe, "bottomright", mover_para, 0)
		
		self.bar_mod = mover_para + (-3)
		self.bgdisplay_loc = mover_para
		
		--> cancel movement if any
		if (self.baseframe:GetScript ("OnUpdate") and self.baseframe:GetScript ("OnUpdate") == move_barras) then
			self.baseframe:SetScript ("OnUpdate", nil)
		end
	end
	
	local nao_mostradas = self.rows_showing - self.rows_fit_in_window
	local slider_height = nao_mostradas*self.row_height
	self.scroll.scrollMax = slider_height
	self.scroll:SetMinMaxValues (0, slider_height)
	
	self.rolagem = true
	self.scroll:Enable()
	main:EnableMouseWheel (true)

	self.scroll:SetValue (0) --> set value pode chamar o atualizador
	self.baseframe.button_down:Enable()
	main.resize_direita:SetPoint ("bottomright", main, "bottomright", self.largura_scroll*-1, 0)
	
	if (main.isLocked) then
		main.lock_button:SetPoint ("bottomright", main, "bottomright", self.largura_scroll*-1, 0)
	end

end

function _detalhes:EsconderScrollBar (sem_animacao, force)

	if (not self.rolagem) then
		return
	end
	
	if (not _detalhes.use_scroll and not force) then
		self.scroll:Disable()
		self.baseframe:EnableMouseWheel (false)
		self.rolagem = false
		return
	end
	
	local main = self.baseframe

	if (not sem_animacao and _detalhes.animate_scroll) then
		self:MoveBarrasTo (self.row_info.space.right + 3) --> 
	else
		for index = 1, self.rows_fit_in_window do
			self.barras [index]:SetWidth (self.baseframe:GetWidth() - 5) --> -5 space between row end and window right border
		end
		self.bgdisplay:SetPoint ("bottomright", self.baseframe, "bottomright", 0, 0) -- voltar o background na poci��o inicial
		self.bar_mod = 0 -- zera o bar mod, uma vez que as barras v�o estar na pocis�o inicial
		self.bgdisplay_loc = -2
		if (self.baseframe:GetScript ("OnUpdate") and self.baseframe:GetScript ("OnUpdate") == move_barras) then
			self.baseframe:SetScript ("OnUpdate", nil)
		end
	end

	self.rolagem = false
	self.scroll:Disable()
	main:EnableMouseWheel (false)
	
	main.resize_direita:SetPoint ("bottomright", main, "bottomright", 0, 0)
	if (main.isLocked) then
		main.lock_button:SetPoint ("bottomright", main, "bottomright", 0, 0)
	end
end

local function OnLeaveMainWindow (instancia, self)

	if (instancia.modo ~= _detalhes._detalhes_props["MODO_ALONE"] and not instancia.baseframe.isLocked) then

		--> resizes and lock button
		instancia.baseframe.resize_direita:SetAlpha (0)
		instancia.baseframe.resize_esquerda:SetAlpha (0)
		gump:Fade (instancia.baseframe.lock_button, 1)
		
		--> stretch button
		--gump:Fade (instancia.baseframe.button_stretch, -1)
		gump:Fade (instancia.baseframe.button_stretch, "ALPHA", 0)
		
		--> snaps
		instancia.botao_separar:SetAlpha (0)
	
	elseif (instancia.modo ~= _detalhes._detalhes_props["MODO_ALONE"] and instancia.baseframe.isLocked) then
		gump:Fade (instancia.baseframe.lock_button, 1)
		gump:Fade (instancia.baseframe.button_stretch, "ALPHA", 0)
		instancia.botao_separar:SetAlpha (0)
		
	end
end
_detalhes.OnLeaveMainWindow = OnLeaveMainWindow

local function OnEnterMainWindow (instancia, self)

	if (instancia.modo ~= _detalhes._detalhes_props["MODO_ALONE"] and not instancia.baseframe.isLocked) then

		--> resizes and lock button
		instancia.baseframe.resize_direita:SetAlpha (1)
		instancia.baseframe.resize_esquerda:SetAlpha (1)

		gump:Fade (instancia.baseframe.lock_button, 0)
		
		--> stretch button
		gump:Fade (instancia.baseframe.button_stretch, "ALPHA", 0.6)
	
		--> snaps
		for _, instancia_id in _pairs (instancia.snap) do
			if (instancia_id) then
				instancia.botao_separar:SetAlpha (1)
				break
			end
		end
		
	elseif (instancia.modo ~= _detalhes._detalhes_props["MODO_ALONE"] and instancia.baseframe.isLocked) then
		gump:Fade (instancia.baseframe.lock_button, 0)
		gump:Fade (instancia.baseframe.button_stretch, "ALPHA", 0.6)
		
		--> snaps
		for _, instancia_id in _pairs (instancia.snap) do
			if (instancia_id) then
				instancia.botao_separar:SetAlpha (1)
				break
			end
		end
	
	end
end
_detalhes.OnEnterMainWindow = OnEnterMainWindow

local function VPL (instancia, esta_instancia)
	--> conferir esquerda
	if (instancia.ponto4.x < esta_instancia.ponto1.x) then --> a janela esta a esquerda
		if (instancia.ponto4.x+20 > esta_instancia.ponto1.x) then --> a janela esta a menos de 20 pixels de dist�ncia
			if (instancia.ponto4.y < esta_instancia.ponto1.y + 20 and instancia.ponto4.y > esta_instancia.ponto1.y - 20) then --> a janela esta a +20 ou -20 pixels de dist�ncia na vertical
				return 1
			end
		end
	end
	return nil
end

local function VPB (instancia, esta_instancia)
	--> conferir baixo
	if (instancia.ponto1.y+20 < esta_instancia.ponto2.y-16) then --> a janela esta em baixo
		if (instancia.ponto1.x > esta_instancia.ponto2.x-20 and instancia.ponto1.x < esta_instancia.ponto2.x+20) then --> a janela esta a 20 pixels de dist�ncia para a esquerda ou para a direita
			if (instancia.ponto1.y+20 > esta_instancia.ponto2.y-16-20) then --> esta a 20 pixels de dist�ncia
				return 2
			end
		end
	end
	return nil
end

local function VPR (instancia, esta_instancia)
	--> conferir lateral direita
	if (instancia.ponto2.x > esta_instancia.ponto3.x) then --> a janela esta a direita
		if (instancia.ponto2.x-20 < esta_instancia.ponto3.x) then --> a janela esta a menos de 20 pixels de dist�ncia
			if (instancia.ponto2.y < esta_instancia.ponto3.y + 20 and instancia.ponto2.y > esta_instancia.ponto3.y - 20) then --> a janela esta a +20 ou -20 pixels de dist�ncia na vertical
				return 3
			end
		end
	end
	return nil
end

local function VPT (instancia, esta_instancia)
	--> conferir cima
	if (instancia.ponto3.y-16 > esta_instancia.ponto4.y+20) then --> a janela esta em cima
		if (instancia.ponto3.x > esta_instancia.ponto4.x-20 and instancia.ponto3.x < esta_instancia.ponto4.x+20) then --> a janela esta a 20 pixels de dist�ncia para a esquerda ou para a direita
			if (esta_instancia.ponto4.y+20+20 > instancia.ponto3.y-16) then
				return 4
			end
		end
	end
	return nil
end

local tempo_movendo, precisa_ativar, instancia_alvo, tempo_fades, nao_anexados
local movement_onupdate = function (self, elapsed) 

				if (tempo_movendo and tempo_movendo < 0) then

					if (precisa_ativar) then --> se a inst�ncia estiver fechada
						gump:Fade (instancia_alvo.baseframe, "ALPHA", 0.2)
						gump:Fade (instancia_alvo.baseframe.cabecalho.ball, "ALPHA", 0.2)
						gump:Fade (instancia_alvo.baseframe.cabecalho.atributo_icon, "ALPHA", 0.2)
						instancia_alvo:SaveMainWindowPosition()
						instancia_alvo:RestoreMainWindowPosition()
						precisa_ativar = false
						
					elseif (tempo_fades) then
						for lado, livre in _ipairs (nao_anexados) do
							if (livre) then
								if (lado == 1) then
									instancia_alvo.h_esquerda:Flash (tempo_fades, tempo_fades, 2.0, false, 0, 0)
								elseif (lado == 2) then
									instancia_alvo.h_baixo:Flash (tempo_fades, tempo_fades, 2.0, false, 0, 0)
								elseif (lado == 3) then
									instancia_alvo.h_direita:Flash (tempo_fades, tempo_fades, 2.0, false, 0, 0)
								elseif (lado == 4) then
									instancia_alvo.h_cima:Flash (tempo_fades, tempo_fades, 2.0, false, 0, 0)
								end
							end
						end
						
						tempo_movendo = 1
					else
						self:SetScript ("OnUpdate", nil)
						tempo_movendo = 1
					end
					
				else
					tempo_movendo = tempo_movendo - elapsed
				end
			end

local function move_janela (baseframe, iniciando, instancia)

	instancia_alvo = _detalhes.tabela_instancias [instancia.meu_id-1]

	if (iniciando) then
	
		baseframe.isMoving = true
		instancia:BaseFrameSnap()
		baseframe:StartMoving()
		
		local _, ClampLeft, ClampRight = instancia:InstanciasHorizontais()
		local _, ClampBottom, ClampTop = instancia:InstanciasVerticais()
		
		if (ClampTop == 0) then
			ClampTop = 0
		end
		if (ClampBottom == 0) then
			ClampBottom = 0
		end
		
		baseframe:SetClampRectInsets (-ClampLeft, ClampRight, ClampTop, -ClampBottom)
		
		if (instancia_alvo) then
		
			tempo_fades = 1.0
			nao_anexados = {true, true, true, true}
			tempo_movendo = 1
			
			for lado, snap_to in _pairs (instancia_alvo.snap) do
				if (snap_to) then
					if (snap_to == instancia.meu_id) then
						tempo_fades = nil
						break
					end
					nao_anexados [lado] = false
				end
			end
			
			for lado = 1, 4 do
				if (instancia_alvo.horizontalSnap and instancia.verticalSnap) then
					nao_anexados [lado] = false
				elseif (instancia_alvo.horizontalSnap and lado == 2) then
					nao_anexados [lado] = false
				elseif (instancia_alvo.horizontalSnap and lado == 4) then
					nao_anexados [lado] = false
				elseif (instancia_alvo.verticalSnap and lado == 1) then
					nao_anexados [lado] = false
				elseif (instancia_alvo.verticalSnap and lado == 3) then
					nao_anexados [lado] = false
				end
			end

			local need_start = not instancia_alvo.iniciada
			precisa_ativar = not instancia_alvo.ativa
			
			if (need_start) then --> se a inst�ncia n�o tiver sido aberta ainda

				instancia_alvo:RestauraJanela (instancia_alvo.meu_id, true)
				if (instancia_alvo:IsSoloMode()) then
					_detalhes.SoloTables:switch()
				end
				instancia_alvo.ativa = false --> isso n�o ta legal
				instancia_alvo:SaveMainWindowPosition()
				instancia_alvo:RestoreMainWindowPosition()
				gump:Fade (instancia_alvo.baseframe, 1)
				gump:Fade (instancia_alvo.baseframe.cabecalho.ball, 1)
				gump:Fade (instancia_alvo.baseframe.cabecalho.atributo_icon, 1)
				need_start = false
			end
			
			baseframe:SetScript ("OnUpdate", movement_onupdate)
		end
		
	else

		baseframe:StopMovingOrSizing()
		baseframe.isMoving = false
		baseframe:SetScript ("OnUpdate", nil)
		
		--baseframe:SetClampRectInsets (unpack (_detalhes.window_clamp))

		if (instancia_alvo) then
			instancia:AtualizaPontos()
			
			local esquerda, baixo, direita, cima
			local meu_id = instancia.meu_id --> id da inst�ncia que esta sendo movida
			
			local isVertical = instancia_alvo.verticalSnap
			local isHorizontal = instancia_alvo.horizontalSnap
			
			local isSelfVertical = instancia.verticalSnap
			local isSelfHorizontal = instancia.horizontalSnap
			
			local _R, _T, _L, _B
			
			if (isVertical and not isSelfHorizontal) then
				_T, _B = VPB (instancia, instancia_alvo), VPT (instancia, instancia_alvo)
			elseif (isHorizontal and not isSelfVertical) then
				_R, _L = VPL (instancia, instancia_alvo), VPR (instancia, instancia_alvo)
			elseif (not isVertical and not isHorizontal) then
				_R, _T, _L, _B = VPL (instancia, instancia_alvo), VPB (instancia, instancia_alvo), VPR (instancia, instancia_alvo), VPT (instancia, instancia_alvo)
			end
			
			if (_L) then
				if (not instancia:EstaAgrupada (instancia_alvo, _L)) then
					esquerda = instancia_alvo.meu_id
					instancia.horizontalSnap = true
					instancia_alvo.horizontalSnap = true
				end
			end
			
			if (_B) then
				if (not instancia:EstaAgrupada (instancia_alvo, _B)) then
					baixo = instancia_alvo.meu_id
					instancia.verticalSnap = true
					instancia_alvo.verticalSnap = true
				end
			end
			
			if (_R) then
				if (not instancia:EstaAgrupada (instancia_alvo, _R)) then
					direita = instancia_alvo.meu_id
					instancia.horizontalSnap = true
					instancia_alvo.horizontalSnap = true
				end
			end
			
			if (_T) then
				if (not instancia:EstaAgrupada (instancia_alvo, _T)) then
					cima = instancia_alvo.meu_id
					instancia.verticalSnap = true
					instancia_alvo.verticalSnap = true
				end
			end
			
			if (esquerda or baixo or direita or cima) then
				instancia:agrupar_janelas ({esquerda, baixo, direita, cima})
			end

			for _, esta_instancia in _ipairs (_detalhes.tabela_instancias) do
				if (not esta_instancia:IsAtiva() and esta_instancia.iniciada) then
					esta_instancia:ResetaGump()
					gump:Fade (esta_instancia.baseframe, "in", 0.2)
					gump:Fade (esta_instancia.baseframe.cabecalho.ball, "in", 0.2)
					gump:Fade (esta_instancia.baseframe.cabecalho.atributo_icon, "in", 0.2)
					
					if (esta_instancia.modo == modo_raid) then
						_detalhes.raid = nil
					elseif (esta_instancia.modo == modo_alone) then
						_detalhes.SoloTables:switch()
						_detalhes.solo = nil
					end

				elseif (esta_instancia:IsAtiva()) then
					esta_instancia:SaveMainWindowPosition()
					esta_instancia:RestoreMainWindowPosition()
				end
			end
		end
	end
end

local function BGFrame_scripts (BG, baseframe, instancia)

	BG:SetScript("OnEnter", function (self)
		OnEnterMainWindow (instancia, self)
	end)
	
	BG:SetScript("OnLeave", function (self)
		OnLeaveMainWindow (instancia, self)
	end)
	
	BG:SetScript ("OnMouseDown", function (frame, button)
		if (baseframe.isMoving) then
			move_janela (baseframe, false, instancia)
			instancia:SaveMainWindowPosition()
			return
		end

		if (not baseframe.isLocked and button == "LeftButton") then
			move_janela (baseframe, true, instancia) --> novo movedor da janela
		elseif (button == "RightButton") then
			_detalhes.switch:ShowMe (instancia)
		end
	end)

	BG:SetScript ("OnMouseUp", function (frame)
		if (baseframe.isMoving) then
			move_janela (baseframe, false, instancia) --> novo movedor da janela
			instancia:SaveMainWindowPosition()
		end
	end)	
end

function gump:RegisterForDetailsMove (frame, instancia)

	frame:SetScript ("OnMouseDown", function (frame, button)
		if (not instancia.baseframe.isLocked and button == "LeftButton") then
			move_janela (instancia.baseframe, true, instancia) --> novo movedor da janela
		end
	end)

	frame:SetScript ("OnMouseUp", function (frame)
		if (instancia.baseframe.isMoving) then
			move_janela (instancia.baseframe, false, instancia) --> novo movedor da janela
			instancia:SaveMainWindowPosition()
		end
	end)	
end

--> scripts do base frame
local function BFrame_scripts (baseframe, instancia)

	baseframe:SetScript("OnSizeChanged", function (self)
		instancia:SaveMainWindowPosition()
		instancia:ReajustaGump()
		_detalhes:SendEvent ("DETAILS_INSTANCE_SIZECHANGED", nil, instancia)
	end)

	baseframe:SetScript("OnEnter", function (self)
		OnEnterMainWindow (instancia, self)
	end)
	
	baseframe:SetScript("OnLeave", function (self)
		OnLeaveMainWindow (instancia, self)
	end)
	
	baseframe:SetScript ("OnMouseDown", function (frame, button)
		if (not baseframe.isLocked and button == "LeftButton") then
			move_janela (baseframe, true, instancia) --> novo movedor da janela
		end
	end)

	baseframe:SetScript ("OnMouseUp", function (frame)
		if (baseframe.isMoving) then
			move_janela (baseframe, false, instancia) --> novo movedor da janela
			instancia:SaveMainWindowPosition()
		end
	end)	

end

local function backgrounddisplay_scripts (backgrounddisplay, baseframe, instancia)

	backgrounddisplay:SetScript ("OnEnter", function (self)
		OnEnterMainWindow (instancia, self)
	end)
	
	backgrounddisplay:SetScript ("OnLeave", function (self) 
		OnLeaveMainWindow (instancia, self)
	end)
end

local function instancias_horizontais (instancia, largura, esquerda, direita)
	if (esquerda) then
		for lado, esta_instancia in _pairs (instancia.snap) do 
			if (lado == 1) then --> movendo para esquerda
				local instancia = _detalhes.tabela_instancias [esta_instancia]
				instancia.baseframe:SetWidth (largura)
				instancia.auto_resize = true
				instancia:ReajustaGump()
				instancia.auto_resize = false
				instancias_horizontais (instancia, largura, true, false)
				_detalhes:SendEvent ("DETAILS_INSTANCE_SIZECHANGED", nil, instancia)
			end
		end
	end
	
	if (direita) then
		for lado, esta_instancia in _pairs (instancia.snap) do 
			if (lado == 3) then --> movendo para esquerda
				local instancia = _detalhes.tabela_instancias [esta_instancia]
				instancia.baseframe:SetWidth (largura)
				instancia.auto_resize = true
				instancia:ReajustaGump()
				instancia.auto_resize = false
				instancias_horizontais (instancia, largura, false, true)
				_detalhes:SendEvent ("DETAILS_INSTANCE_SIZECHANGED", nil, instancia)
			end
		end
	end
end

local function instancias_verticais (instancia, altura, esquerda, direita)
	if (esquerda) then
		for lado, esta_instancia in _pairs (instancia.snap) do 
			if (lado == 1) then --> movendo para esquerda
				local instancia = _detalhes.tabela_instancias [esta_instancia]
				instancia.baseframe:SetHeight (altura)
				instancia.auto_resize = true
				instancia:ReajustaGump()
				instancia.auto_resize = false
				instancias_verticais (instancia, altura, true, false)
				_detalhes:SendEvent ("DETAILS_INSTANCE_SIZECHANGED", nil, instancia)
			end
		end
	end
	
	if (direita) then
		for lado, esta_instancia in _pairs (instancia.snap) do 
			if (lado == 3) then --> movendo para esquerda
				local instancia = _detalhes.tabela_instancias [esta_instancia]
				instancia.baseframe:SetHeight (altura)
				instancia.auto_resize = true
				instancia:ReajustaGump()
				instancia.auto_resize = false
				instancias_verticais (instancia, altura, false, true)
				_detalhes:SendEvent ("DETAILS_INSTANCE_SIZECHANGED", nil, instancia)
			end
		end
	end
end

function _detalhes:InstanciasVerticais (instancia)

	instancia = self or instancia

	local linha_vertical, baixo, cima = {}, 0, 0

	local checking = instancia
	local first = true
	
	local check_index_anterior = _detalhes.tabela_instancias [instancia.meu_id-1]
	if (check_index_anterior) then --> possiu uma inst�ncia antes de mim
		if (check_index_anterior.snap[4] and check_index_anterior.snap[4] == instancia.meu_id) then --> o index negativo vai para baixo
			for i = instancia.meu_id-1, 1, -1 do 
				local esta_instancia = _detalhes.tabela_instancias [i]
				if (esta_instancia.snap[4] and esta_instancia.snap [4] == checking.meu_id) then
					linha_vertical [#linha_vertical+1] = esta_instancia
					if (first) then
						baixo = baixo + esta_instancia.baseframe:GetHeight()+48
						first = false
					else
						baixo = baixo + esta_instancia.baseframe:GetHeight()+34
					end
					checking = esta_instancia
				else
					break
				end
			end
		elseif (check_index_anterior.snap[2] and check_index_anterior.snap[2] == instancia.meu_id) then --> o index negativo vai para cima
			for i = instancia.meu_id-1, 1, -1 do 
				local esta_instancia = _detalhes.tabela_instancias [i]
				if (esta_instancia.snap[2] and esta_instancia.snap[2] == checking.meu_id) then
					linha_vertical [#linha_vertical+1] = esta_instancia
					if (first) then
						cima = cima + esta_instancia.baseframe:GetHeight() + 64
						first = false
					else
						cima = cima + esta_instancia.baseframe:GetHeight() + 34
					end
					checking = esta_instancia
				else
					break
				end
			end
		end
	end
	
	checking = instancia
	first = true
	
	local check_index_posterior = _detalhes.tabela_instancias [instancia.meu_id+1]
	if (check_index_posterior) then
		if (check_index_posterior.snap[4] and check_index_posterior.snap[4] == instancia.meu_id) then --> o index posterior vai para a esquerda
			for i = instancia.meu_id+1, #_detalhes.tabela_instancias do 
				local esta_instancia = _detalhes.tabela_instancias [i]
				if (esta_instancia.snap[4] and esta_instancia.snap[4] == checking.meu_id) then
					linha_vertical [#linha_vertical+1] = esta_instancia
					if (first) then
						baixo = baixo + esta_instancia.baseframe:GetHeight()+48
						first = true
					else
						baixo = baixo + esta_instancia.baseframe:GetHeight()+34
					end
					checking = esta_instancia
				else
					break
				end
			end
		elseif (check_index_posterior.snap[2] and check_index_posterior.snap[2] == instancia.meu_id) then --> o index posterior vai para a direita
			for i = instancia.meu_id+1, #_detalhes.tabela_instancias do 
				local esta_instancia = _detalhes.tabela_instancias [i]
				if (esta_instancia.snap[2] and esta_instancia.snap[2] == checking.meu_id) then
					linha_vertical [#linha_vertical+1] = esta_instancia
					if (first) then
						cima = cima + esta_instancia.baseframe:GetHeight() + 64
						first = false
					else
						cima = cima + esta_instancia.baseframe:GetHeight() + 34
					end
					checking = esta_instancia
				else
					break
				end
			end
		end
	end

	
	
	return linha_vertical, baixo, cima
	
end

--[[
			lado 4
	-----------------------------------------
	|					|
lado 1	|					| lado 3
	|					|
	|					|
	-----------------------------------------
			lado 2
--]]

function _detalhes:InstanciasHorizontais (instancia)

	instancia = self or instancia

	local linha_horizontal, esquerda, direita = {}, 0, 0
	
	local top, bottom = 0, 0

	local checking = instancia
	
	local check_index_anterior = _detalhes.tabela_instancias [instancia.meu_id-1]
	if (check_index_anterior) then --> possiu uma inst�ncia antes de mim
		if (check_index_anterior.snap[3] and check_index_anterior.snap[3] == instancia.meu_id) then --> o index negativo vai para a esquerda
			for i = instancia.meu_id-1, 1, -1 do 
				local esta_instancia = _detalhes.tabela_instancias [i]
				if (esta_instancia.snap[3]) then
					if (esta_instancia.snap[3] == checking.meu_id) then
						linha_horizontal [#linha_horizontal+1] = esta_instancia
						esquerda = esquerda + esta_instancia.baseframe:GetWidth()
						checking = esta_instancia
					end
				else
					break
				end
			end
		elseif (check_index_anterior.snap[1] and check_index_anterior.snap[1] == instancia.meu_id) then --> o index negativo vai para a direita
			for i = instancia.meu_id-1, 1, -1 do 
				local esta_instancia = _detalhes.tabela_instancias [i]
				if (esta_instancia.snap[1]) then
					if (esta_instancia.snap[1] == checking.meu_id) then
						linha_horizontal [#linha_horizontal+1] = esta_instancia
						direita = direita + esta_instancia.baseframe:GetWidth()
						checking = esta_instancia
					end
				else
					break
				end
			end
		end
	end
	
	checking = instancia
	
	local check_index_posterior = _detalhes.tabela_instancias [instancia.meu_id+1]
	if (check_index_posterior) then
		if (check_index_posterior.snap[3] and check_index_posterior.snap[3] == instancia.meu_id) then --> o index posterior vai para a esquerda
			for i = instancia.meu_id+1, #_detalhes.tabela_instancias do 
				local esta_instancia = _detalhes.tabela_instancias [i]
				if (esta_instancia.snap[3]) then
					if (esta_instancia.snap[3] == checking.meu_id) then
						linha_horizontal [#linha_horizontal+1] = esta_instancia
						esquerda = esquerda + esta_instancia.baseframe:GetWidth()
						checking = esta_instancia
					end
				else
					break
				end
			end
		elseif (check_index_posterior.snap[1] and check_index_posterior.snap[1] == instancia.meu_id) then --> o index posterior vai para a direita
			for i = instancia.meu_id+1, #_detalhes.tabela_instancias do 
				local esta_instancia = _detalhes.tabela_instancias [i]
				if (esta_instancia.snap[1]) then
					if (esta_instancia.snap[1] == checking.meu_id) then
						linha_horizontal [#linha_horizontal+1] = esta_instancia
						direita = direita + esta_instancia.baseframe:GetWidth()
						checking = esta_instancia
					end
				else
					break
				end
			end
		end
	end

	return linha_horizontal, esquerda, direita, bottom, top
	
end

local resizeTooltip = {
	{text = "|cff33CC00Click|cffEEEEEE: ".. Loc ["STRING_RESIZE_COMMON"]},
	
	{text = "+|cff33CC00 Click|cffEEEEEE: " .. Loc ["STRING_RESIZE_HORIZONTAL"]},
	{icon = [[Interface\AddOns\Details\images\key_shift]], width = 24, height = 14, l = 0, r = 1, t = 0, b =0.640625},
	
	{text = "+|cff33CC00 Click|cffEEEEEE: " .. Loc ["STRING_RESIZE_VERTICAL"]},
	{icon = [[Interface\AddOns\Details\images\key_alt]], width = 24, height = 14, l = 0, r = 1, t = 0, b =0.640625},
	
	{text = "+|cff33CC00 Click|cffEEEEEE: " .. Loc ["STRING_RESIZE_ALL"]},
	{icon = [[Interface\AddOns\Details\images\key_ctrl]], width = 24, height = 14, l = 0, r = 1, t = 0, b =0.640625}
}

--> search key: ~resizescript
local function resize_scripts (resizer, instancia, scrollbar, side, baseframe)

	resizer:SetScript ("OnMouseDown", function (self, button) 
	
		_G.GameCooltip:ShowMe (false) --> Hide Cooltip
		
		if (not self:GetParent().isLocked and button == "LeftButton" and instancia.modo ~= _detalhes._detalhes_props["MODO_ALONE"]) then 
			self:GetParent().isResizing = true
			instancia:BaseFrameSnap()

			local isVertical = instancia.verticalSnap
			local isHorizontal = instancia.horizontalSnap
		
			local agrupadas
			if (instancia.verticalSnap) then
				agrupadas = instancia:InstanciasVerticais()
			elseif (instancia.horizontalSnap) then
				agrupadas = instancia:InstanciasHorizontais()
			end

			instancia.stretchToo = agrupadas
			if (instancia.stretchToo and #instancia.stretchToo > 0) then
				for _, esta_instancia in ipairs (instancia.stretchToo) do 
					esta_instancia.baseframe._place = esta_instancia:SaveMainWindowPosition()
					esta_instancia.baseframe.isResizing = true
				end
			end
			
		----------------
		
			if (side == "<") then
				if (_IsShiftKeyDown()) then
					instancia.baseframe:StartSizing("left")
					instancia.eh_horizontal = true
				elseif (_IsAltKeyDown()) then
					instancia.baseframe:StartSizing("top")
					instancia.eh_vertical = true
				elseif (_IsControlKeyDown()) then
					instancia.baseframe:StartSizing("bottomleft")
					instancia.eh_tudo = true
				else
					instancia.baseframe:StartSizing("bottomleft")
				end
				
				resizer:SetPoint ("bottomleft", baseframe, "bottomleft", -1, -1)
				resizer.afundado = true
				
			elseif (side == ">") then
				if (_IsShiftKeyDown()) then
					instancia.baseframe:StartSizing("right")
					instancia.eh_horizontal = true
				elseif (_IsAltKeyDown()) then
					instancia.baseframe:StartSizing("top")
					instancia.eh_vertical = true
				elseif (_IsControlKeyDown()) then
					instancia.baseframe:StartSizing("bottomright")
					instancia.eh_tudo = true
				else
					instancia.baseframe:StartSizing("bottomright")
				end
				
				if (instancia.rolagem and _detalhes.use_scroll) then
					resizer:SetPoint ("bottomright", baseframe, "bottomright", (instancia.largura_scroll*-1) + 1, -1)
				else
					resizer:SetPoint ("bottomright", baseframe, "bottomright", 1, -1)
				end
				resizer.afundado = true
			end
			
			_detalhes:SendEvent ("DETAILS_INSTANCE_STARTRESIZE", nil, instancia)
			
		end 
	end)
	
	resizer:SetScript ("OnMouseUp", function (self,button) 
	
			if (resizer.afundado) then
				resizer.afundado = false
				if (resizer.side == 2) then
					if (instancia.rolagem and _detalhes.use_scroll) then
						resizer:SetPoint ("bottomright", baseframe, "bottomright", instancia.largura_scroll*-1, 0)
					else
						resizer:SetPoint ("bottomright", baseframe, "bottomright", 0, 0)
					end
				else
					resizer:SetPoint ("bottomleft", baseframe, "bottomleft", 0, 0)
				end
			end
	
			if (self:GetParent().isResizing) then 
			
				self:GetParent():StopMovingOrSizing()
				self:GetParent().isResizing = false
				
				if (instancia.stretchToo and #instancia.stretchToo > 0) then
					for _, esta_instancia in ipairs (instancia.stretchToo) do 
						esta_instancia.baseframe:StopMovingOrSizing()
						esta_instancia.baseframe.isResizing = false
						esta_instancia:ReajustaGump()
						_detalhes:SendEvent ("DETAILS_INSTANCE_SIZECHANGED", nil, esta_instancia)
					end
					instancia.stretchToo = nil
				end	
				
				local largura = instancia.baseframe:GetWidth()
				local altura = instancia.baseframe:GetHeight()
				
				if (instancia.eh_horizontal) then
					instancias_horizontais (instancia, largura, true, true)
					instancia.eh_horizontal = nil
				end
				
				--if (instancia.eh_vertical) then
					instancias_verticais (instancia, altura, true, true)
					instancia.eh_vertical = nil
				--end
				
				_detalhes:SendEvent ("DETAILS_INSTANCE_ENDRESIZE", nil, instancia)
				
				if (instancia.eh_tudo) then
					for _, esta_instancia in _ipairs (_detalhes.tabela_instancias) do
						if (esta_instancia:IsAtiva() and esta_instancia.modo ~= _detalhes._detalhes_props["MODO_ALONE"]) then
							esta_instancia.baseframe:ClearAllPoints()
							esta_instancia:SaveMainWindowPosition()
							esta_instancia:RestoreMainWindowPosition()
						end
					end
					
					for _, esta_instancia in _ipairs (_detalhes.tabela_instancias) do
						if (esta_instancia:IsAtiva() and esta_instancia ~= instancia and esta_instancia.modo ~= _detalhes._detalhes_props["MODO_ALONE"]) then
							esta_instancia.baseframe:SetWidth (largura)
							esta_instancia.baseframe:SetHeight (altura)
							esta_instancia.auto_resize = true
							esta_instancia:ReajustaGump()
							esta_instancia.auto_resize = false
							_detalhes:SendEvent ("DETAILS_INSTANCE_SIZECHANGED", nil, esta_instancia)
						end
					end

					instancia.eh_tudo = nil
				end
				
				instancia:BaseFrameSnap()
				
				for _, esta_instancia in _ipairs (_detalhes.tabela_instancias) do
					if (esta_instancia:IsAtiva()) then
						esta_instancia:SaveMainWindowPosition()
						esta_instancia:RestoreMainWindowPosition()
					end
				end
			end 
		end)
		
	resizer:SetScript ("OnHide", function (self) 
		if (self.going_hide) then
			_G.GameCooltip:ShowMe (false)
			self.going_hide = nil
		end
	end)
	
	resizer:SetScript ("OnEnter", function (self) 
		if (instancia.modo ~= _detalhes._detalhes_props["MODO_ALONE"] and not instancia.baseframe.isLocked and not self.mostrando) then

			OnEnterMainWindow (instancia, self)
		
			self.texture:SetBlendMode ("ADD")
			self.mostrando = true
			
			_G.GameCooltip:Reset()
			_G.GameCooltip:SetType ("tooltip")
			_G.GameCooltip:AddFromTable (resizeTooltip)
			_G.GameCooltip:SetOption ("NoLastSelectedBar", true)
			_G.GameCooltip:SetOwner (resizer)
			_G.GameCooltip:ShowCooltip()
		end
	end)
	
	resizer:SetScript ("OnLeave", function (self) 

		if (self.mostrando) then

			resizer.going_hide = true
			if (not self.movendo) then
				OnLeaveMainWindow (instancia, self)
			end

			self.texture:SetBlendMode ("BLEND")
			self.mostrando = false
			
			_G.GameCooltip:ShowMe (false)
		end
	end)
end


local function lock_button_scripts (button, instancia)
	button:SetScript ("OnEnter", function (self) 
	
		OnEnterMainWindow (instancia, self)
		
		if (instancia.modo ~= _detalhes._detalhes_props["MODO_ALONE"]) then
			self.label:SetTextColor (1, 1, 1, .6)
			self.mostrando = true
		end
		
	end)

	button:SetScript ("OnLeave", function (self) 
	
		OnLeaveMainWindow (instancia, self)
		self.label:SetTextColor (.3, .3, .3, .6)
		self.mostrando = false
		
	end)
end

local lockFunctionOnClick = function (button)
	local baseframe = button:GetParent()
	if (baseframe.isLocked) then
		baseframe.isLocked = false
		baseframe.instance.isLocked = false
		button.label:SetText (Loc ["STRING_LOCK_WINDOW"])
		button:SetWidth (button.label:GetStringWidth()+2)
		baseframe.resize_direita:SetAlpha (1)
		baseframe.resize_esquerda:SetAlpha (1)
		button:ClearAllPoints()
		button:SetPoint ("right", baseframe.resize_direita, "left", -1, 1.5)		
	else
		baseframe.isLocked = true
		baseframe.instance.isLocked = true
		button.label:SetText (Loc ["STRING_UNLOCK_WINDOW"])
		button:SetWidth (button.label:GetStringWidth()+2)
		button:ClearAllPoints()
		button:SetPoint ("bottomright", baseframe, "bottomright", -3, 0)
		baseframe.resize_direita:SetAlpha (0)
		baseframe.resize_esquerda:SetAlpha (0)
	end
end
_detalhes.lock_instance_function = lockFunctionOnClick

local function bota_separar_script (botao, instancia)
	botao:SetScript ("OnEnter", function (self) 
		OnEnterMainWindow (instancia, self)
		self.mostrando = true
	end)
	
	botao:SetScript ("OnLeave", function (self) 
		OnLeaveMainWindow (instancia, self)
		self.mostrando = false
	end)
end

local function barra_scripts (esta_barra, instancia, i)

	esta_barra:SetScript ("OnEnter", function (self) 
		self.mouse_over = true
		OnEnterMainWindow (instancia, esta_barra)

		instancia:MontaTooltip (self, i)
		
		self:SetBackdrop({
			bgFile = [[Interface\Tooltips\UI-Tooltip-Background]], 
			tile = true, tileSize = 16,
			insets = {left = 1, right = 1, top = 0, bottom = 1},})	
			self:SetBackdropColor (0.588, 0.588, 0.588, 0.7)
	end)

	esta_barra:SetScript ("OnLeave", function (self) 
		self.mouse_over = false
		OnLeaveMainWindow (instancia, self)
		
		_GameTooltip:Hide()
		_G.GameCooltip:ShowMe (false)
		
		self:SetBackdrop({
			bgFile = "", edgeFile = "", tile = true, tileSize = 16, edgeSize = 32,
			insets = {left = 1, right = 1, top = 0, bottom = 1},})	

			self:SetBackdropBorderColor (0, 0, 0, 0)
			self:SetBackdropColor (0, 0, 0, 0)
	end)

	esta_barra:SetScript ("OnMouseDown", function (self, button)
		
		if (esta_barra.fading_in) then
			return
		end

		if (button == "RightButton") then
			return _detalhes.switch:ShowMe (instancia)
		end
	
		esta_barra.texto_esquerdo:SetPoint ("left", esta_barra.icone_classe, "right", 4, -1)
		esta_barra.texto_direita:SetPoint ("right", esta_barra.statusbar, "right", 1, -1)
	
		self.mouse_down = _GetTime()
		self.button = button
		local x, y = _GetCursorPosition()
		self.x = _math_floor (x)
		self.y = _math_floor (y)
	
		local parent = instancia.baseframe
		if ((not parent.isLocked) or (parent.isLocked == 0)) then
			GameCooltip:Hide() --> fecha o tooltip
			move_janela (parent, true, instancia) --> novo movedor da janela
		end

	end)
	
	esta_barra:SetScript ("OnMouseUp", function (self, button)
	
		local parent = instancia.baseframe
		if (parent.isMoving) then
		
			move_janela (parent, false, instancia) --> novo movedor da janela
			instancia:SaveMainWindowPosition()
			_GameTooltip:SetOwner (self, "ANCHOR_TOPRIGHT")
			if (instancia:MontaTooltip (self, i)) then
				GameCooltip:Show (esta_barra, 1)
			end
			
		end

		esta_barra.texto_esquerdo:SetPoint ("left", esta_barra.icone_classe, "right", 3, 0)
		esta_barra.texto_direita:SetPoint ("right", esta_barra.statusbar, "right")
		
		local x, y = _GetCursorPosition()
		x = _math_floor (x)
		y = _math_floor (y)

		if (self.mouse_down and (self.mouse_down+0.4 > _GetTime() and (x == self.x and y == self.y)) or (x == self.x and y == self.y)) then
			--> a �nica maneira de abrir a janela de info � por aqui...

			if (self.button == "LeftButton") then
				if (instancia.atributo == 5 or _IsShiftKeyDown()) then 
					--> report
					return _detalhes:ReportSingleLine (instancia, self)
				end
				instancia:AbreJanelaInfo (self.minha_tabela)
			end

		end
	end)

	esta_barra:SetScript ("OnClick", function (self, button)

		end)
end

function _detalhes:ReportSingleLine (instancia, barra)

	local reportar
	if (instancia.atributo == 5) then --> custom
		reportar = {"Details! " .. Loc ["STRING_CUSTOM_REPORT"] .. " " ..instancia.customName}
	else
		reportar = {"Details! " .. Loc ["STRING_REPORT"] .. " " .. _detalhes.sub_atributos [instancia.atributo].lista [instancia.sub_atributo]}
	end

	reportar [#reportar+1] = barra.texto_esquerdo:GetText().." "..barra.texto_direita:GetText()

	return _detalhes:Reportar (reportar, {_no_current = true, _no_inverse = true, _custom = true})
end

local function button_stretch_scripts (baseframe, backgrounddisplay, instancia)
	local button = baseframe.button_stretch

	button:SetScript ("OnEnter", function (self)
		self.mouse_over = true
		gump:Fade (self, "ALPHA", 1)
	end)
	button:SetScript ("OnLeave", function (self)
		self.mouse_over = false
		gump:Fade (self, "ALPHA", 0)
	end)	

	button:SetScript ("OnMouseDown", function (self)

		if (instancia:IsSoloMode()) then
			return
		end
	
		instancia:EsconderScrollBar (true)
		baseframe._place = instancia:SaveMainWindowPosition()
		baseframe.isResizing = true
		baseframe.isStretching = true
		baseframe:SetFrameStrata ("TOOLTIP")
		
		local _r, _g, _b, _a = baseframe:GetBackdropColor()
		gump:GradientEffect ( baseframe, "frame", _r, _g, _b, _a, _r, _g, _b, 0.9, 1.5)
		if (instancia.wallpaper.enabled) then
			_r, _g, _b = baseframe.wallpaper:GetVertexColor()
			_a = baseframe.wallpaper:GetAlpha()
			gump:GradientEffect (baseframe.wallpaper, "texture", _r, _g, _b, _a, _r, _g, _b, 0.05, 0.5)
		end
		
		if (instancia.stretch_button_side == 1) then
			baseframe:StartSizing ("top")
		elseif (instancia.stretch_button_side == 2) then
			baseframe:StartSizing ("bottom")
		end
		
		local linha_horizontal = {}
	
		local checking = instancia
		for i = instancia.meu_id-1, 1, -1 do 
			local esta_instancia = _detalhes.tabela_instancias [i]
			if ((esta_instancia.snap[1] and esta_instancia.snap[1] == checking.meu_id) or (esta_instancia.snap[3] and esta_instancia.snap[3] == checking.meu_id)) then
				linha_horizontal [#linha_horizontal+1] = esta_instancia
				checking = esta_instancia
			else
				break
			end
		end
		
		checking = instancia
		for i = instancia.meu_id+1, #_detalhes.tabela_instancias do 
			local esta_instancia = _detalhes.tabela_instancias [i]
			if ((esta_instancia.snap[1] and esta_instancia.snap[1] == checking.meu_id) or (esta_instancia.snap[3] and esta_instancia.snap[3] == checking.meu_id)) then
				linha_horizontal [#linha_horizontal+1] = esta_instancia
				checking = esta_instancia
			else
				break
			end
		end
		
		instancia.stretchToo = linha_horizontal
		if (#instancia.stretchToo > 0) then
			for _, esta_instancia in ipairs (instancia.stretchToo) do 
				esta_instancia:EsconderScrollBar (true)
				esta_instancia.baseframe._place = esta_instancia:SaveMainWindowPosition()
				esta_instancia.baseframe.isResizing = true
				esta_instancia.baseframe.isStretching = true
				esta_instancia.baseframe:SetFrameStrata ("TOOLTIP")
				
				local _r, _g, _b, _a = esta_instancia.baseframe:GetBackdropColor()
				gump:GradientEffect ( esta_instancia.baseframe, "frame", _r, _g, _b, _a, _r, _g, _b, 0.9, 1.5)
				_detalhes:SendEvent ("DETAILS_INSTANCE_STARTSTRETCH", nil, esta_instancia)
				
				if (esta_instancia.wallpaper.enabled) then
					_r, _g, _b = esta_instancia.baseframe.wallpaper:GetVertexColor()
					_a = esta_instancia.baseframe.wallpaper:GetAlpha()
					gump:GradientEffect (esta_instancia.baseframe.wallpaper, "texture", _r, _g, _b, _a, _r, _g, _b, 0.05, 0.5)
				end
				
			end
		end
		
		_detalhes:SnapTextures (true)
		
		_detalhes:SendEvent ("DETAILS_INSTANCE_STARTSTRETCH", nil, instancia)
	end)
	
	button:SetScript ("OnMouseUp", function(self) 
	
		if (instancia:IsSoloMode()) then
			return
		end
	
		if (baseframe.isResizing) then 
			baseframe:StopMovingOrSizing()
			baseframe.isResizing = false
			instancia:RestoreMainWindowPosition (baseframe._place)
			instancia:ReajustaGump()
			baseframe.isStretching = false
			if (instancia.need_rolagem) then
				instancia:MostrarScrollBar (true)
			end
			_detalhes:SendEvent ("DETAILS_INSTANCE_SIZECHANGED", nil, instancia)
			
			if (instancia.stretchToo and #instancia.stretchToo > 0) then
				for _, esta_instancia in ipairs (instancia.stretchToo) do 
					esta_instancia.baseframe:StopMovingOrSizing()
					esta_instancia.baseframe.isResizing = false
					esta_instancia:RestoreMainWindowPosition (esta_instancia.baseframe._place)
					esta_instancia:ReajustaGump()
					esta_instancia.baseframe.isStretching = false
					if (esta_instancia.need_rolagem) then
						esta_instancia:MostrarScrollBar (true)
					end
					_detalhes:SendEvent ("DETAILS_INSTANCE_SIZECHANGED", nil, esta_instancia)
					
					local _r, _g, _b, _a = esta_instancia.baseframe:GetBackdropColor()
					gump:GradientEffect ( esta_instancia.baseframe, "frame", _r, _g, _b, _a, instancia.bg_r, instancia.bg_g, instancia.bg_b, instancia.bg_alpha, 0.5)
					
					if (esta_instancia.wallpaper.enabled) then
						_r, _g, _b = esta_instancia.baseframe.wallpaper:GetVertexColor()
						_a = esta_instancia.baseframe.wallpaper:GetAlpha()
						gump:GradientEffect (esta_instancia.baseframe.wallpaper, "texture", _r, _g, _b, _a, _r, _g, _b, esta_instancia.baseframe.wallpaper.alpha, 1.0)
					end
					
					esta_instancia.baseframe:SetFrameStrata ("LOW")
					esta_instancia.baseframe.button_stretch:SetFrameStrata ("FULLSCREEN")
					_detalhes:SendEvent ("DETAILS_INSTANCE_ENDSTRETCH", nil, esta_instancia.baseframe)
				end
				instancia.stretchToo = nil
			end
			
		end 
		
		local _r, _g, _b, _a = baseframe:GetBackdropColor()
		gump:GradientEffect ( baseframe, "frame", _r, _g, _b, _a, instancia.bg_r, instancia.bg_g, instancia.bg_b, instancia.bg_alpha, 0.5)
		if (instancia.wallpaper.enabled) then
			_r, _g, _b = baseframe.wallpaper:GetVertexColor()
			_a = baseframe.wallpaper:GetAlpha()
			gump:GradientEffect (baseframe.wallpaper, "texture", _r, _g, _b, _a, _r, _g, _b, instancia.wallpaper.alpha, 1.0)
		end
		
		baseframe:SetFrameStrata ("LOW")
		baseframe.button_stretch:SetFrameStrata ("FULLSCREEN")
		
		_detalhes:SnapTextures (false)
		
		_detalhes:SendEvent ("DETAILS_INSTANCE_ENDSTRETCH", nil, instancia)
	end)	
end

local function button_down_scripts (main_frame, backgrounddisplay, instancia, scrollbar)
	main_frame.button_down:SetScript ("OnMouseDown", function(self)
		if (not scrollbar:IsEnabled()) then
			return
		end
		
		local B = instancia.barraS[2]
		if (B < instancia.rows_showing) then
			scrollbar:SetValue (scrollbar:GetValue() + instancia.row_height)
		end
		
		self.precionado = true
		self.last_up = -0.3
		self:SetScript ("OnUpdate", function(self, elapsed)
			self.last_up = self.last_up + elapsed
			if (self.last_up > 0.03) then
				self.last_up = 0
				B = instancia.barraS[2]
				if (B < instancia.rows_showing) then
					scrollbar:SetValue (scrollbar:GetValue() + instancia.row_height)
				else
					self:Disable()
				end
			end
		end)
	end)
	
	main_frame.button_down:SetScript ("OnMouseUp", function (self) 
		self.precionado = false
		self:SetScript ("OnUpdate", nil)
	end)
end

local function button_up_scripts (main_frame, backgrounddisplay, instancia, scrollbar)

	main_frame.button_up:SetScript ("OnMouseDown", function(self) 
		if (not scrollbar:IsEnabled()) then
			return
		end
		
		local A = instancia.barraS[1]
		if (A > 1) then
			scrollbar:SetValue (scrollbar:GetValue() - instancia.row_height)
		end
		
		self.precionado = true
		self.last_up = -0.3
		self:SetScript ("OnUpdate", function (self, elapsed)
			self.last_up = self.last_up + elapsed
			if (self.last_up > 0.03) then
				self.last_up = 0
				A = instancia.barraS[1]
				if (A > 1) then
					scrollbar:SetValue (scrollbar:GetValue() - instancia.row_height)
				else
					self:Disable()
				end
			end
		end)
	end)
	
	main_frame.button_up:SetScript ("OnMouseUp", function (self) 
		self.precionado = false
		self:SetScript ("OnUpdate", nil)
	end)	

	main_frame.button_up:SetScript ("OnEnable", function (self)
		local current = scrollbar:GetValue()
		if (current == 0) then
			main_frame.button_up:Disable()
		end
	end)
end

local function iterate_scroll_scripts (backgrounddisplay, backgroundframe, baseframe, scrollbar, instancia)

	baseframe:SetScript ("OnMouseWheel", 
		function (self, delta)
			if (delta > 0) then --> rolou pra cima
				local A = instancia.barraS[1]
				if (A > 1) then
					scrollbar:SetValue (scrollbar:GetValue() - instancia.row_height)
				else
					scrollbar:SetValue (0)
					scrollbar.ultimo = 0
					baseframe.button_up:Disable()
				end
			elseif (delta < 0) then --> rolou pra baixo
				local B = instancia.barraS[2]
				if (B < instancia.rows_showing) then
					scrollbar:SetValue (scrollbar:GetValue() + instancia.row_height)
				else
					local _, maxValue = scrollbar:GetMinMaxValues()
					scrollbar:SetValue (maxValue)
					scrollbar.ultimo = maxValue
					baseframe.button_down:Disable()
				end
			end

		end)

	scrollbar:SetScript ("OnValueChanged", function (self)
		local ultimo = self.ultimo
		local meu_valor = self:GetValue()
		if (ultimo == meu_valor) then --> n�o mudou
			return
		end
		
		--> shortcut
		local minValue, maxValue = scrollbar:GetMinMaxValues()
		if (minValue == meu_valor) then
			instancia.barraS[1] = 1
			instancia.barraS[2] = instancia.rows_fit_in_window
			instancia:AtualizaGumpPrincipal (instancia, true)
			self.ultimo = meu_valor
			baseframe.button_up:Disable()
				return
		elseif (maxValue == meu_valor) then
			local min = instancia.rows_showing -instancia.rows_fit_in_window
			min = min+1
			if (min < 1) then
				min = 1
			end
			instancia.barraS[1] = min
			instancia.barraS[2] = instancia.rows_showing
			instancia:AtualizaGumpPrincipal (instancia, true)
			self.ultimo = meu_valor
			baseframe.button_down:Disable()
			return
		end
		
		if (not baseframe.button_up:IsEnabled()) then
			baseframe.button_up:Enable()
		end
		if (not baseframe.button_down:IsEnabled()) then
			baseframe.button_down:Enable()
		end
		
		if (meu_valor > ultimo) then --> scroll down
		
			local B = instancia.barraS[2]
			if (B < instancia.rows_showing) then --> se o valor maximo n�o for o m�ximo de barras a serem mostradas	
				local precisa_passar = ((B+1) * instancia.row_height) - (instancia.row_height*instancia.rows_fit_in_window)
				if (meu_valor > precisa_passar) then --> o valor atual passou o valor que precisa passar pra locomover
					local diff = meu_valor - ultimo --> pega a diferen�a de H
					diff = diff / instancia.row_height --> calcula quantas barras ele pulou
					diff = _math_ceil (diff) --> arredonda para cima
					if (instancia.barraS[2]+diff > instancia.rows_showing and ultimo > 0) then
						instancia.barraS[1] = instancia.rows_showing - (instancia.rows_fit_in_window-1)
						instancia.barraS[2] = instancia.rows_showing
					else
						instancia.barraS[2] = instancia.barraS[2]+diff
						instancia.barraS[1] = instancia.barraS[1]+diff
					end
					instancia:AtualizaGumpPrincipal (instancia, true)
				end
			end
		else --> scroll up
			local A = instancia.barraS[1]
			if (A > 1) then
				local precisa_passar = (A-1) * instancia.row_height
				if (meu_valor < precisa_passar) then
					--> calcula quantas barras passou
					local diff = ultimo - meu_valor
					diff = diff / instancia.row_height
					diff = _math_ceil (diff)
					if (instancia.barraS[1]-diff < 1) then
						instancia.barraS[2] = instancia.rows_fit_in_window
						instancia.barraS[1] = 1
					else
						instancia.barraS[2] = instancia.barraS[2]-diff
						instancia.barraS[1] = instancia.barraS[1]-diff
					end

					instancia:AtualizaGumpPrincipal (instancia, true)
				end
			end
		end
		self.ultimo = meu_valor
	end)		
end

function _detalhes:HaveInstanceAlert()
	return self.alert:IsShown()
end

function _detalhes:InstanceAlertTime (instance)
	instance.alert:Hide()
	instance.alert.rotate:Stop()
	instance.alert_time = nil
end

function _detalhes:InstanceAlert (msg, icon, time, clickfunc)
	
	if (not self.meu_id) then
		local lower = _detalhes:GetLowerInstanceNumber()
		if (lower) then
			self = _detalhes:GetInstance (lower)
		else
			return
		end
	end
	
	if (type (msg) == "boolean" and not msg) then
		self.alert:Hide()
		self.alert.rotate:Stop()
		self.alert_time = nil
		return
	end
	
	if (msg) then
		self.alert.text:SetText (msg)
	else
		self.alert.text:SetText ("")
	end
	
	if (icon) then
		if (type (icon) == "table") then
			local texture, w, h, animate, l, r, t, b = unpack (icon)
			
			self.alert.icon:SetTexture (texture)
			self.alert.icon:SetWidth (w or 14)
			self.alert.icon:SetHeight (h or 14)
			if (l and r and t and b) then
				self.alert.icon:SetTexCoord (l, r, t, b)
			end
			if (animate) then
				self.alert.rotate:Play()
			end
		else
			self.alert.icon:SetWidth (14)
			self.alert.icon:SetHeight (14)
			self.alert.icon:SetTexture (icon)
			self.alert.icon:SetTexCoord (0, 1, 0, 1)
		end
	else
		self.alert.icon:SetTexture (nil)
	end
	
	if (clickfunc) then
		self.alert.button:SetClickFunction (unpack (clickfunc))
	else
		self.alert.button.clickfunction = nil
	end

	if (time) then
		self.alert_time = time
		_detalhes:ScheduleTimer ("InstanceAlertTime", time, self)
	end
	
	self.alert:Show()
end

function CreateAlertFrame (baseframe, instancia)

	local alert_bg = CreateFrame ("frame", nil, baseframe)
	alert_bg:SetPoint ("bottom", baseframe, "bottom")
	alert_bg:SetPoint ("left", baseframe, "left", 3, 0)
	alert_bg:SetPoint ("right", baseframe, "right", -3, 0)
	alert_bg:SetHeight (12)
	alert_bg:SetBackdrop ({bgFile = [[Interface\AddOns\Details\images\background]], tile = true, tileSize = 16,
	insets = {left = 0, right = 0, top = 0, bottom = 0}})
	alert_bg:SetBackdropColor (.1, .1, .1, 1)
	alert_bg:SetFrameStrata ("HIGH")
	alert_bg:SetFrameLevel (baseframe:GetFrameLevel() + 6)
	alert_bg:Hide()

	local toptexture = alert_bg:CreateTexture (nil, "background")
	toptexture:SetTexture ([[Interface\Challenges\challenges-main]])
	--toptexture:SetTexCoord (0.1921484375, 0.523671875, 0.234375, 0.160859375)
	toptexture:SetTexCoord (0.231171875, 0.4846484375, 0.0703125, 0.072265625)
	toptexture:SetPoint ("left", alert_bg, "left")
	toptexture:SetPoint ("right", alert_bg, "right")
	toptexture:SetPoint ("bottom", alert_bg, "top", 0, 0)
	toptexture:SetHeight (1)
	
	local text = alert_bg:CreateFontString (nil, "overlay", "GameFontNormal")
	text:SetPoint ("right", alert_bg, "right", -14, 0)
	_detalhes:SetFontSize (text, 10)
	text:SetTextColor (1, 1, 1, 1)
	
	local rotate_frame = CreateFrame ("frame", nil, alert_bg)
	rotate_frame:SetWidth (12)
	rotate_frame:SetPoint ("right", alert_bg, "right", -2, 0)
	rotate_frame:SetHeight (alert_bg:GetWidth())
	
	local icon = rotate_frame:CreateTexture (nil, "overlay")
	icon:SetPoint ("center", rotate_frame, "center")
	icon:SetWidth (14)
	icon:SetHeight (14)
	
	local button = gump:NewButton (alert_bg, nil, "DetailsInstance"..instancia.meu_id.."AlertButton", nil, 1, 1)
	button:SetAllPoints()
	button:SetHook ("OnMouseUp", function() alert_bg:Hide() end)
	
	local RotateAnimGroup = rotate_frame:CreateAnimationGroup()
	local rotate = RotateAnimGroup:CreateAnimation ("Rotation")
	rotate:SetDegrees (360)
	rotate:SetDuration (6)
	RotateAnimGroup:SetLooping ("repeat")
	
	alert_bg:Hide()	
	
	alert_bg.text = text
	alert_bg.icon = icon
	alert_bg.button = button
	alert_bg.rotate = RotateAnimGroup
	
	instancia.alert = alert_bg
	
	return alert_bg
end

function _detalhes:InstanceMsg (text, icon, textcolor, icontexture, iconcoords, iconcolor)
	if (not text) then
		self.freeze_icon:Hide()
		return self.freeze_texto:Hide()
	end
	
	self.freeze_texto:SetText (text)
	self.freeze_icon:SetTexture (icon)

	self.freeze_icon:Show()
	self.freeze_texto:Show()
	
	if (textcolor) then
		local r, g, b, a = gump:ParseColors (textcolor)
		self.freeze_texto:SetTextColor (r, g, b, a)
	else
		self.freeze_texto:SetTextColor (1, 1, 1, 1)
	end

	if (icontexture) then
		self.freeze_icon:SetTexture (icontexture)
	else
		self.freeze_icon:SetTexture ([[Interface\CHARACTERFRAME\Disconnect-Icon]])
	end
	
	if (iconcoords and type (iconcoords) == "table") then
		self.freeze_icon:SetTexCoord (_unpack (iconcoords))
	else
		self.freeze_icon:SetTexCoord (0, 1, 0, 1)
	end
	
	if (iconcolor) then
		local r, g, b, a = gump:ParseColors (iconcolor)
		self.freeze_icon:SetVertexColor (r, g, b, a)
	else
		self.freeze_icon:SetVertexColor (1, 1, 1, 1)
	end
end

--> inicio
function gump:CriaJanelaPrincipal (ID, instancia, criando)

-- main frames -----------------------------------------------------------------------------------------------------------------------------------------------

	local baseframe = CreateFrame ("scrollframe", "DetailsBaseFrame"..ID, _UIParent) --> main frame
	baseframe.instance = instancia
	baseframe:SetFrameStrata ("LOW")
	baseframe:SetFrameLevel (2)

	local backgroundframe =  CreateFrame ("scrollframe", "Details_WindowFrame"..ID, baseframe) --> main window
	local backgrounddisplay = CreateFrame ("frame", "Details_GumpFrame"..ID, backgroundframe) --> background window
	backgroundframe:SetFrameLevel (3)
	backgrounddisplay:SetFrameLevel (3)
	backgroundframe.instance = instancia
	backgrounddisplay.instance = instancia

	local switchbutton = gump:NewDetailsButton (backgrounddisplay, baseframe, _, function() end, nil, nil, 1, 1, "", "", "", "", 
	{rightFunc = {func = function() _detalhes.switch:ShowMe (instancia) end, param1 = nil, param2 = nil}})
	
	switchbutton:SetPoint ("topleft", backgrounddisplay, "topleft")
	switchbutton:SetPoint ("bottomright", backgrounddisplay, "bottomright")
	switchbutton:SetFrameLevel (backgrounddisplay:GetFrameLevel()+1)

-- scroll bar -----------------------------------------------------------------------------------------------------------------------------------------------

	local scrollbar = CreateFrame ("slider", "Details_ScrollBar"..ID, backgrounddisplay) --> scroll
	
	--> scroll image-node up
		baseframe.scroll_up = backgrounddisplay:CreateTexture (nil, "background")
		baseframe.scroll_up:SetPoint ("topleft", backgrounddisplay, "topright", 0, 0)
		baseframe.scroll_up:SetTexture (DEFAULT_SKIN)
		baseframe.scroll_up:SetTexCoord (unpack (COORDS_SLIDER_TOP))
		baseframe.scroll_up:SetWidth (32)
		baseframe.scroll_up:SetHeight (32)
	
	--> scroll image-node down
		baseframe.scroll_down = backgrounddisplay:CreateTexture (nil, "background")
		baseframe.scroll_down:SetPoint ("bottomleft", backgrounddisplay, "bottomright", 0, 0)
		baseframe.scroll_down:SetTexture (DEFAULT_SKIN)
		baseframe.scroll_down:SetTexCoord (unpack (COORDS_SLIDER_DOWN))
		baseframe.scroll_down:SetWidth (32)
		baseframe.scroll_down:SetHeight (32)
	
	--> scroll image-node middle
		baseframe.scroll_middle = backgrounddisplay:CreateTexture (nil, "background")
		baseframe.scroll_middle:SetPoint ("top", baseframe.scroll_up, "bottom", 0, 8)
		baseframe.scroll_middle:SetPoint ("bottom", baseframe.scroll_down, "top", 0, -11)
		baseframe.scroll_middle:SetTexture (DEFAULT_SKIN)
		baseframe.scroll_middle:SetTexCoord (unpack (COORDS_SLIDER_MIDDLE))
		baseframe.scroll_middle:SetWidth (32)
		baseframe.scroll_middle:SetHeight (64)
	
	--> scroll widgets
		baseframe.button_up = CreateFrame ("button", nil, backgrounddisplay)
		baseframe.button_down = CreateFrame ("button", nil, backgrounddisplay)
	
		baseframe.button_up:SetWidth (29)
		baseframe.button_up:SetHeight (32)
		baseframe.button_up:SetNormalTexture ([[Interface\BUTTONS\UI-ScrollBar-ScrollUpButton-Up]])
		baseframe.button_up:SetPushedTexture ([[Interface\BUTTONS\UI-ScrollBar-ScrollUpButton-Down]])
		baseframe.button_up:SetDisabledTexture ([[Interface\BUTTONS\UI-ScrollBar-ScrollUpButton-Disabled]])
		baseframe.button_up:Disable()

		baseframe.button_down:SetWidth (29)
		baseframe.button_down:SetHeight (32)
		baseframe.button_down:SetNormalTexture ([[Interface\BUTTONS\UI-ScrollBar-ScrollDownButton-Up]])
		baseframe.button_down:SetPushedTexture ([[Interface\BUTTONS\UI-ScrollBar-ScrollDownButton-Down]])
		baseframe.button_down:SetDisabledTexture ([[Interface\BUTTONS\UI-ScrollBar-ScrollDownButton-Disabled]])
		baseframe.button_down:Disable()

		baseframe.button_up:SetPoint ("topright", baseframe.scroll_up, "topright", -4, 3)
		baseframe.button_down:SetPoint ("bottomright", baseframe.scroll_down, "bottomright", -4, -6)

		scrollbar:SetPoint ("top", baseframe.button_up, "bottom", 0, 12)
		scrollbar:SetPoint ("bottom", baseframe.button_down, "top", 0, -12)
		scrollbar:SetPoint ("left", backgrounddisplay, "right", 3, 0)
		scrollbar:Show()

		--> config set
		scrollbar:SetOrientation ("VERTICAL")
		scrollbar.scrollMax = 0 --default - tamanho da janela de fundo
		scrollbar:SetMinMaxValues (0, 0)
		scrollbar:SetValue (0)
		scrollbar.ultimo = 0
		
		--> thumb
		scrollbar.thumb = scrollbar:CreateTexture (nil, "overlay")
		scrollbar.thumb:SetTexture ([[Interface\Buttons\UI-ScrollBar-Knob]])
		scrollbar.thumb:SetSize (29, 30)
		scrollbar:SetThumbTexture (scrollbar.thumb)
		
		--> scripts
		button_down_scripts (baseframe, backgrounddisplay, instancia, scrollbar)
		button_up_scripts (baseframe, backgrounddisplay, instancia, scrollbar)
	
-- stretch button -----------------------------------------------------------------------------------------------------------------------------------------------

		baseframe.button_stretch = CreateFrame ("button", nil, baseframe)
		baseframe.button_stretch:SetPoint ("bottom", baseframe, "top", 0, 20)
		baseframe.button_stretch:SetPoint ("right", baseframe, "right", -27, 0)
		baseframe.button_stretch:SetFrameStrata ("FULLSCREEN")
	
		local stretch_texture = baseframe.button_stretch:CreateTexture (nil, "overlay")
		stretch_texture:SetTexture (DEFAULT_SKIN)
		stretch_texture:SetTexCoord (unpack (COORDS_STRETCH))
		stretch_texture:SetWidth (32)
		stretch_texture:SetHeight (16)
		stretch_texture:SetAllPoints (baseframe.button_stretch)
		baseframe.button_stretch.texture = stretch_texture
		
		baseframe.button_stretch:SetWidth (32)
		baseframe.button_stretch:SetHeight (16)
		
		baseframe.button_stretch:Show()
		gump:Fade (baseframe.button_stretch, "ALPHA", 0)

		button_stretch_scripts (baseframe, backgrounddisplay, instancia)

-- main window config -------------------------------------------------------------------------------------------------------------------------------------------------

		baseframe:SetClampedToScreen (true)
		--baseframe:SetClampRectInsets (unpack (_detalhes.window_clamp))
		
		baseframe:SetSize (_detalhes.new_window_size.width, _detalhes.new_window_size.height)
		
		baseframe:SetPoint ("center", _UIParent)
		baseframe:EnableMouseWheel (false)
		baseframe:EnableMouse (true)
		baseframe:SetMovable (true)
		baseframe:SetResizable (true)
		baseframe:SetMinResize (150, 40)
		baseframe:SetMaxResize (_detalhes.max_window_size.width, _detalhes.max_window_size.height)

		baseframe:SetBackdrop (gump_fundo_backdrop)
		baseframe:SetBackdropColor (instancia.bg_r, instancia.bg_g, instancia.bg_b, instancia.bg_alpha)
	
-- background window config -------------------------------------------------------------------------------------------------------------------------------------------------

		backgroundframe:SetAllPoints (baseframe)
		backgroundframe:SetScrollChild (backgrounddisplay)
		
		backgrounddisplay:SetResizable (true)
		backgrounddisplay:SetPoint ("topleft", baseframe, "topleft")
		backgrounddisplay:SetPoint ("bottomright", baseframe, "bottomright")
		backgrounddisplay:SetBackdrop (gump_fundo_backdrop)
		backgrounddisplay:SetBackdropColor (instancia.bg_r, instancia.bg_g, instancia.bg_b, instancia.bg_alpha)
	
-- instance mini widgets -------------------------------------------------------------------------------------------------------------------------------------------------

	--> freeze icon
		instancia.freeze_icon = backgrounddisplay:CreateTexture (nil, "overlay")
			instancia.freeze_icon:SetWidth (64)
			instancia.freeze_icon:SetHeight (64)
			instancia.freeze_icon:SetPoint ("center", backgrounddisplay, "center")
			instancia.freeze_icon:SetPoint ("left", backgrounddisplay, "left")
			instancia.freeze_icon:Hide()
	
		instancia.freeze_texto = backgrounddisplay:CreateFontString (nil, "overlay", "GameFontHighlightSmall")
			instancia.freeze_texto:SetHeight (64)
			instancia.freeze_texto:SetPoint ("left", instancia.freeze_icon, "right", -18, 0)
			instancia.freeze_texto:SetTextColor (1, 1, 1)
			instancia.freeze_texto:Hide()
	
	--> details version
		instancia._version = baseframe:CreateFontString (nil, "overlay", "GameFontHighlightSmall")
			--instancia._version:SetPoint ("left", backgrounddisplay, "left", 20, 0)
			instancia._version:SetTextColor (1, 1, 1)
			instancia._version:SetText ("this is a alpha version of Details\nyou can help us sending bug reports\nuse the blue button.")
			if (not _detalhes.initializing) then
				
			end
			instancia._version:Hide()
			

	--> wallpaper
		baseframe.wallpaper = backgrounddisplay:CreateTexture (nil, "overlay")
		baseframe.wallpaper:Hide()
	
	--> alert frame
		baseframe.alert = CreateAlertFrame (baseframe, instancia)
	
-- resizers & lock button ------------------------------------------------------------------------------------------------------------------------------------------------------------

	--> right resizer
		baseframe.resize_direita = CreateFrame ("button", "Details_Resize_Direita"..ID, baseframe)
		
		local resize_direita_texture = baseframe.resize_direita:CreateTexture (nil, "overlay")
		resize_direita_texture:SetWidth (16)
		resize_direita_texture:SetHeight (16)
		resize_direita_texture:SetTexture (DEFAULT_SKIN)
		resize_direita_texture:SetTexCoord (unpack (COORDS_RESIZE_RIGHT))
		resize_direita_texture:SetAllPoints (baseframe.resize_direita)
		baseframe.resize_direita.texture = resize_direita_texture

		baseframe.resize_direita:SetWidth (16)
		baseframe.resize_direita:SetHeight (16)
		baseframe.resize_direita:SetPoint ("bottomright", baseframe, "bottomright", 0, 0)
		baseframe.resize_direita:EnableMouse (true)
		baseframe.resize_direita:SetFrameLevel (baseframe:GetFrameLevel() + 6)
		baseframe.resize_direita:SetFrameStrata ("HIGH")
		baseframe.resize_direita.side = 2

	--> lock window button
		baseframe.lock_button = CreateFrame ("button", "Details_Lock_Button"..ID, baseframe)
		baseframe.lock_button:SetPoint ("right", baseframe.resize_direita, "left", -1, 1.5)
		baseframe.lock_button:SetFrameLevel (baseframe:GetFrameLevel() + 6)
		baseframe.lock_button:SetWidth (40)
		baseframe.lock_button:SetHeight (16)
		baseframe.lock_button.label = baseframe.lock_button:CreateFontString (nil, "overlay", "GameFontNormal")
		baseframe.lock_button.label:SetPoint ("right", baseframe.lock_button, "right")
		baseframe.lock_button.label:SetTextColor (.3, .3, .3, .6)
		baseframe.lock_button.label:SetJustifyH ("right")
		baseframe.lock_button.label:SetText (Loc ["STRING_LOCK_WINDOW"])
		baseframe.lock_button:SetWidth (baseframe.lock_button.label:GetStringWidth()+2)
		baseframe.lock_button:SetScript ("OnClick", lockFunctionOnClick)
	
	--> left resizer
		baseframe.resize_esquerda = CreateFrame ("button", "Details_Resize_Esquerda"..ID, baseframe)
		
		local resize_esquerda_texture = baseframe.resize_esquerda:CreateTexture (nil, "overlay")
		resize_esquerda_texture:SetWidth (16)
		resize_esquerda_texture:SetHeight (16)
		resize_esquerda_texture:SetTexture (DEFAULT_SKIN)
		resize_esquerda_texture:SetTexCoord (unpack (COORDS_RESIZE_LEFT))
		resize_esquerda_texture:SetAllPoints (baseframe.resize_esquerda)
		baseframe.resize_esquerda.texture = resize_esquerda_texture

		baseframe.resize_esquerda:SetWidth (16)
		baseframe.resize_esquerda:SetHeight (16)
		baseframe.resize_esquerda:SetPoint ("bottomleft", baseframe, "bottomleft", 0, 0)
		baseframe.resize_esquerda:EnableMouse (true)
		baseframe.resize_esquerda:SetFrameLevel (baseframe:GetFrameLevel() + 6)
		baseframe.resize_esquerda:SetFrameStrata ("HIGH")
	
		baseframe.resize_esquerda:SetAlpha (0)
		baseframe.resize_direita:SetAlpha (0)
	
		if (instancia.isLocked) then
			instancia.isLocked = not instancia.isLocked
			lockFunctionOnClick (baseframe.lock_button)
		end
	
		gump:Fade (baseframe.lock_button, -1, 3.0)

-- scripts ------------------------------------------------------------------------------------------------------------------------------------------------------------

	BFrame_scripts (baseframe, instancia)

	BGFrame_scripts (switchbutton, baseframe, instancia)
	BGFrame_scripts (backgrounddisplay, baseframe, instancia)
	
	iterate_scroll_scripts (backgrounddisplay, backgroundframe, baseframe, scrollbar, instancia)
	

-- create toolbar ----------------------------------------------------------------------------------------------------------------------------------------------------------

	gump:CriaCabecalho (baseframe, instancia)
	
-- create statusbar ----------------------------------------------------------------------------------------------------------------------------------------------------------		

	gump:CriaRodape (baseframe, instancia)

-- left and right side bars ------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ~barra ~bordas ~border
	--> left
		baseframe.barra_esquerda = baseframe.cabecalho.fechar:CreateTexture (nil, "artwork")
		baseframe.barra_esquerda:SetTexture (DEFAULT_SKIN)
		baseframe.barra_esquerda:SetTexCoord (unpack (COORDS_LEFT_SIDE_BAR))
		baseframe.barra_esquerda:SetWidth (64)
		baseframe.barra_esquerda:SetHeight	(512)
		baseframe.barra_esquerda:SetPoint ("topleft", baseframe, "topleft", -56, 0)
		baseframe.barra_esquerda:SetPoint ("bottomleft", baseframe, "bottomleft", -56, -14)
	--> right
		baseframe.barra_direita = baseframe.cabecalho.fechar:CreateTexture (nil, "artwork")
		baseframe.barra_direita:SetTexture (DEFAULT_SKIN)
		baseframe.barra_direita:SetTexCoord (unpack (COORDS_RIGHT_SIDE_BAR))
		baseframe.barra_direita:SetWidth (64)
		baseframe.barra_direita:SetHeight (512)
		baseframe.barra_direita:SetPoint ("topright", baseframe, "topright", 56, 0)
		baseframe.barra_direita:SetPoint ("bottomright", baseframe, "bottomright", 56, -14)
	--> bottom
		baseframe.barra_fundo = baseframe.cabecalho.fechar:CreateTexture (nil, "artwork")
		baseframe.barra_fundo:SetTexture (DEFAULT_SKIN)
		baseframe.barra_fundo:SetTexCoord (unpack (COORDS_BOTTOM_SIDE_BAR))
		baseframe.barra_fundo:SetWidth (512)
		baseframe.barra_fundo:SetHeight (64)
		baseframe.barra_fundo:SetPoint ("bottomleft", baseframe, "bottomleft", 0, -56)
		baseframe.barra_fundo:SetPoint ("bottomright", baseframe, "bottomright", 0, -56)

-- break snap button ----------------------------------------------------------------------------------------------------------------------------------------------------------

		instancia.botao_separar = CreateFrame ("button", "DetailsBreakSnapButton" .. ID, baseframe.cabecalho.fechar)
		instancia.botao_separar:SetPoint ("bottom", baseframe.resize_direita, "top", -1, 0)
		instancia.botao_separar:SetFrameLevel (baseframe:GetFrameLevel() + 5)
		instancia.botao_separar:SetSize (13, 13)
		
		instancia.botao_separar:SetScript ("OnClick", function()
			instancia:Desagrupar (-1)
		end)

		instancia.botao_separar:SetNormalTexture (DEFAULT_SKIN)
		instancia.botao_separar:SetDisabledTexture (DEFAULT_SKIN)
		instancia.botao_separar:SetHighlightTexture (DEFAULT_SKIN, "ADD")
		instancia.botao_separar:SetPushedTexture (DEFAULT_SKIN)
		
		instancia.botao_separar:GetNormalTexture():SetTexCoord (unpack (COORDS_UNLOCK_BUTTON))
		instancia.botao_separar:GetDisabledTexture():SetTexCoord (unpack (COORDS_UNLOCK_BUTTON))
		instancia.botao_separar:GetHighlightTexture():SetTexCoord (unpack (COORDS_UNLOCK_BUTTON))
		instancia.botao_separar:GetPushedTexture():SetTexCoord (unpack (COORDS_UNLOCK_BUTTON))
		
		instancia.botao_separar:SetAlpha (0)
	
-- scripts ------------------------------------------------------------------------------------------------------------------------------------------------------------	
	
		resize_scripts (baseframe.resize_direita, instancia, scrollbar, ">", baseframe)
		resize_scripts (baseframe.resize_esquerda, instancia, scrollbar, "<", baseframe)
		lock_button_scripts (baseframe.lock_button, instancia)
		bota_separar_script (instancia.botao_separar, instancia)
	
-- side bars highlights ------------------------------------------------------------------------------------------------------------------------------------------------------------

	--> top
		local fcima = CreateFrame ("frame", nil, baseframe.cabecalho.fechar)
		fcima:SetPoint ("topleft", baseframe.cabecalho.top_bg, "bottomleft", -10, 37)
		fcima:SetPoint ("topright", baseframe.cabecalho.ball_r, "bottomright", -33, 37)
		gump:CreateFlashAnimation (fcima)
		fcima:Hide()
		
		instancia.h_cima = fcima:CreateTexture (nil, "overlay")
		instancia.h_cima:SetTexture ([[Interface\AddOns\Details\images\highlight_updown]])
		instancia.h_cima:SetTexCoord (0, 1, 0.5, 1)
		instancia.h_cima:SetPoint ("topleft", baseframe.cabecalho.top_bg, "bottomleft", -10, 37)
		instancia.h_cima:SetPoint ("topright", baseframe.cabecalho.ball_r, "bottomright", -97, 37)
		instancia.h_cima = fcima
		
	--> bottom
		local fbaixo = CreateFrame ("frame", nil, baseframe.cabecalho.fechar)
		fbaixo:SetPoint ("topleft", baseframe.rodape.esquerdo, "bottomleft", 16, 17)
		fbaixo:SetPoint ("topright", baseframe.rodape.direita, "bottomright", -16, 17)
		gump:CreateFlashAnimation (fbaixo)
		fbaixo:Hide()
		
		instancia.h_baixo = fbaixo:CreateTexture (nil, "overlay")
		instancia.h_baixo:SetTexture ([[Interface\AddOns\Details\images\highlight_updown]])
		instancia.h_baixo:SetTexCoord (0, 1, 0, 0.5)
		instancia.h_baixo:SetPoint ("topleft", baseframe.rodape.esquerdo, "bottomleft", 16, 17)
		instancia.h_baixo:SetPoint ("topright", baseframe.rodape.direita, "bottomright", -16, 17)
		instancia.h_baixo = fbaixo
		
	--> left
		local fesquerda = CreateFrame ("frame", nil, baseframe.cabecalho.fechar)
		fesquerda:SetPoint ("topleft", baseframe.barra_esquerda, "topleft", -8, 0)
		fesquerda:SetPoint ("bottomleft", baseframe.barra_esquerda, "bottomleft", -8, 0)
		gump:CreateFlashAnimation (fesquerda)
		fesquerda:Hide()
		
		instancia.h_esquerda = fesquerda:CreateTexture (nil, "overlay")
		instancia.h_esquerda:SetTexture ([[Interface\AddOns\Details\images\highlight_leftright]])
		instancia.h_esquerda:SetTexCoord (0.5, 1, 0, 1)
		instancia.h_esquerda:SetPoint ("topleft", baseframe.barra_esquerda, "topleft", 40, 0)
		instancia.h_esquerda:SetPoint ("bottomleft", baseframe.barra_esquerda, "bottomleft", 40, 0)
		instancia.h_esquerda = fesquerda
		
	--> right
		local fdireita = CreateFrame ("frame", nil, baseframe.cabecalho.fechar)
		fdireita:SetPoint ("topleft", baseframe.barra_direita, "topleft", 8, 18)
		fdireita:SetPoint ("bottomleft", baseframe.barra_direita, "bottomleft", 8, 0)
		gump:CreateFlashAnimation (fdireita)	
		fdireita:Hide()
		
		instancia.h_direita = fdireita:CreateTexture (nil, "overlay")
		instancia.h_direita:SetTexture ([[Interface\AddOns\Details\images\highlight_leftright]])
		instancia.h_direita:SetTexCoord (0, 0.5, 1, 0)
		instancia.h_direita:SetPoint ("topleft", baseframe.barra_direita, "topleft", 8, 18)
		instancia.h_direita:SetPoint ("bottomleft", baseframe.barra_direita, "bottomleft", 8, 0)
		instancia.h_direita = fdireita

--> done

	if (criando) then
		local CProps = {
			["altura"] = 100,
			["largura"] = 200,
			["barras"] = 50,
			["barrasvisiveis"] = 0,
			["x"] = 0,
			["y"] = 0,
			["w"] = 0,
			["h"] = 0
		}
		instancia.locs = CProps
	end

	return baseframe, backgroundframe, backgrounddisplay, scrollbar
	
end

function _detalhes:SetBarGrowDirection (direction)

	if (not direction) then
		direction = self.bars_grow_direction
	end
	
	self.bars_grow_direction = direction
	
	local x = self.row_info.space.left
	
	if (direction == 1) then --> top to bottom
		for index, row in _ipairs (self.barras) do
			local y = self.row_height * (index - 1)
			y = y * -1
			row:ClearAllPoints()
			row:SetPoint ("topleft", self.baseframe, "topleft", x, y)
			
		end
		
	elseif (direction == 2) then --> bottom to top
		for index, row in _ipairs (self.barras) do
			local y = self.row_height * (index - 1)
			row:ClearAllPoints()
			row:SetPoint ("bottomleft", self.baseframe, "bottomleft", x, y + 2)
		end
		
	end
	
	--> update all row width
	if (self.bar_mod and self.bar_mod ~= 0) then
		for index = 1, #self.barras do
			self.barras [index]:SetWidth (self.baseframe:GetWidth() + self.bar_mod)
		end
	else
		for index = 1, #self.barras do
			self.barras [index]:SetWidth (self.baseframe:GetWidth()+self.row_info.space.right)
		end
	end
end

--> Alias
function gump:NewRow (instancia, index)
	return gump:CriaNovaBarra (instancia, index)
end

_detalhes.barras_criadas = 0

--> search key: ~row ~barra
function gump:CriaNovaBarra (instancia, index)

	local baseframe = instancia.baseframe
	local esta_barra = CreateFrame ("button", "DetailsBarra_"..instancia.meu_id.."_"..index, baseframe)
	esta_barra.row_id = index
	local y = instancia.row_height*(index-1)

	if (instancia.bars_grow_direction == 1) then
		y = y*-1
		esta_barra:SetPoint ("topleft", baseframe, "topleft", instancia.row_info.space.left, y)
		
	elseif (instancia.bars_grow_direction == 2) then
		--y = y*-1
		esta_barra:SetPoint ("bottomleft", baseframe, "bottomleft", instancia.row_info.space.left, y + 2)
		
	end
	
	esta_barra:SetHeight (instancia.row_info.height) --> altura determinada pela inst�ncia
	esta_barra:SetWidth (baseframe:GetWidth()+instancia.row_info.space.right)

	esta_barra:SetFrameLevel (baseframe:GetFrameLevel() + 4)

	esta_barra.last_value = 0
	esta_barra.w_mod = 0

	esta_barra:EnableMouse (true)
	esta_barra:RegisterForClicks ("LeftButtonDown", "RightButtonDown")

	esta_barra.statusbar = CreateFrame ("StatusBar", nil, esta_barra)
	--esta_barra.statusbar:SetAllPoints (esta_barra)
	
	esta_barra.textura = esta_barra.statusbar:CreateTexture (nil, "artwork")
	esta_barra.textura:SetHorizTile (false)
	esta_barra.textura:SetVertTile (false)
	esta_barra.textura:SetTexture (instancia.row_info.texture_file)
	
	esta_barra.background = esta_barra:CreateTexture (nil, "background")
	esta_barra.background:SetTexture()
	esta_barra.background:SetAllPoints (esta_barra)

	esta_barra.statusbar:SetStatusBarColor (0, 0, 0, 0)
	esta_barra.statusbar:SetStatusBarTexture (esta_barra.textura)
	
	esta_barra.statusbar:SetMinMaxValues (0, 100)
	esta_barra.statusbar:SetValue (100)

	local icone_classe = esta_barra.statusbar:CreateTexture (nil, "overlay")
	icone_classe:SetHeight (instancia.row_info.height)
	icone_classe:SetWidth (instancia.row_info.height)
	icone_classe:SetTexture ([[Interface\AddOns\Details\images\classes_small]])
	icone_classe:SetTexCoord (.75, 1, .75, 1)
	esta_barra.icone_classe = icone_classe

	icone_classe:SetPoint ("left", esta_barra, "left")
	
	esta_barra.statusbar:SetPoint ("topleft", icone_classe, "topright")
	esta_barra.statusbar:SetPoint ("bottomright", esta_barra, "bottomright")
	
	esta_barra.texto_esquerdo = esta_barra.statusbar:CreateFontString (nil, "overlay", "GameFontHighlight")

	esta_barra.texto_esquerdo:SetPoint ("left", esta_barra.icone_classe, "right", 3, 0)
	esta_barra.texto_esquerdo:SetJustifyH ("left")
	esta_barra.texto_esquerdo:SetNonSpaceWrap (true)

	esta_barra.texto_direita = esta_barra.statusbar:CreateFontString (nil, "overlay", "GameFontHighlight")

	esta_barra.texto_direita:SetPoint ("right", esta_barra.statusbar, "right")
	esta_barra.texto_direita:SetJustifyH ("right")
	
	instancia:SetFontSize (esta_barra.texto_esquerdo, instancia.row_info.font_size)
	instancia:SetFontFace (esta_barra.texto_esquerdo, instancia.row_info.font_face_file)
	_detalhes.font_pool:add (esta_barra.texto_esquerdo)
	
	instancia:SetFontSize (esta_barra.texto_direita, instancia.row_info.font_size)
	instancia:SetFontFace (esta_barra.texto_direita, instancia.row_info.font_face_file)
	_detalhes.font_pool:add (esta_barra.texto_direita)
	
	if (instancia.row_info.textL_outline) then
		instancia:SetFontOutline (esta_barra.texto_esquerdo, instancia.row_info.textL_outline)
	end
	if (instancia.row_info.textR_outline) then
		instancia:SetFontOutline (esta_barra.texto_direita, instancia.row_info.textR_outline)
	end
	
	if (not instancia.row_info.texture_class_colors) then
		esta_barra.textura:SetVertexColor (_unpack (instancia.row_info.fixed_texture_color))
	end
	
	if (not instancia.row_info.textL_class_colors) then
		esta_barra.texto_esquerdo:SetTextColor (_unpack (instancia.row_info.fixed_text_color))
	end
	if (not instancia.row_info.textR_class_colors) then
		esta_barra.texto_direita:SetTextColor (_unpack (instancia.row_info.fixed_text_color))
	end

	--> inicia os scripts da barra
	barra_scripts (esta_barra, instancia, index)
	
	gump:Fade (esta_barra, 1) --> hida a barra
	
	return esta_barra
end

function _detalhes:SetBarTextSettings (size, font, fixedcolor, leftcolorbyclass, rightcolorbyclass, leftoutline, rightoutline)
	
	--> size
	if (size) then
		self.row_info.font_size = size
	end

	--> font
	if (font) then
		self.row_info.font_face = font
		self.row_info.font_face_file = SharedMedia:Fetch ("font", font)
	end

	--> fixed color
	if (fixedcolor) then
		local red, green, blue, alpha = gump:ParseColors (fixedcolor)
		local c = self.row_info.fixed_text_color
		c[1], c[2], c[3], c[4] = red, green, blue, alpha
	end
	
	--> left color by class
	if (type (leftcolorbyclass) == "boolean") then
		self.row_info.textL_class_colors = leftcolorbyclass
	end
	
	--> right color by class
	if (type (rightcolorbyclass) == "boolean") then
		self.row_info.textR_class_colors = rightcolorbyclass
	end
	
	--> left text outline
	if (type (leftoutline) == "boolean") then
		self.row_info.textL_outline = leftoutline
	end
	
	--> right text outline
	if (type (rightoutline) == "boolean") then
		self.row_info.textR_outline = rightoutline
	end
	
	self:InstanceReset()
	self:InstanceRefreshRows()
end

function _detalhes:SetBarSettings (height, texture, colorclass, fixedcolor, backgroundtexture, backgroundcolorclass, backgroundfixedcolor, alpha, iconfile)
	
	--> icon file
	if (iconfile) then
		self.row_info.icon_file = iconfile
	end
	
	--> alpha
	if (alpha) then
		self.row_info.alpha = alpha
	end
	
	--> height
	if (height) then
		self.row_info.height = height
		self.row_height = height + self.row_info.space.between
	end
	
	--> texture
	if (texture) then
		self.row_info.texture = texture
		self.row_info.texture_file = SharedMedia:Fetch ("statusbar", texture)
	end
	
	--> color by class
	if (type (colorclass) == "boolean") then
		self.row_info.texture_class_colors = colorclass
	end
	
	--> fixed color
	if (fixedcolor) then
		local red, green, blue, alpha = gump:ParseColors (fixedcolor)
		local c = self.row_info.fixed_texture_color
		c[1], c[2], c[3], c[4] = red, green, blue, alpha
	end
	
	--> background texture
	if (backgroundtexture) then
		self.row_info.texture_background = backgroundtexture
		self.row_info.texture_background_file = SharedMedia:Fetch ("statusbar", backgroundtexture)
	end
	
	--> background color by class
	if (type (backgroundcolorclass) == "boolean") then
		self.row_info.texture_background_class_color = backgroundcolorclass
	end
	
	--> background fixed color
	if (backgroundfixedcolor) then
		local red, green, blue, alpha = gump:ParseColors (backgroundfixedcolor)
		local c =  self.row_info.fixed_texture_background_color
		c [1], c [2], c [3], c [4] = red, green, blue, alpha
	end

	self:InstanceReset()
	self:InstanceRefreshRows()
	self:ReajustaGump()

end


-- search key: ~row
function _detalhes:InstanceRefreshRows (instancia)

	if (instancia) then
		self = instancia
	end

	if (not self.barras or not self.barras[1]) then
		return
	end
	
	--> outline values
		local left_text_outline = self.row_info.textL_outline
		local right_text_outline = self.row_info.textR_outline
	
	--> texture color values
		local texture_class_color = self.row_info.texture_class_colors
		local texture_r, texture_g, texture_b
		if (not texture_class_color) then
			texture_r, texture_g, texture_b = _unpack (self.row_info.fixed_texture_color)
		end
	
	--text color
		local left_text_class_color = self.row_info.textL_class_colors
		local right_text_class_color = self.row_info.textR_class_colors
		local text_r, text_g, text_b
		if (not left_text_class_color or not right_text_class_color) then
			text_r, text_g, text_b = _unpack (self.row_info.fixed_text_color)
		end
		
		local height = self.row_info.height
	
	--alpha
		local alpha = self.row_info.alpha
	
	-- do it

	for _, row in _ipairs (self.barras) do 

		--> positioning and size
		row:SetHeight (height)
		row.icone_classe:SetHeight (height)
		row.icone_classe:SetWidth (height)
	
		if (not self.row_info.texture_background_class_color) then
			local c = self.row_info.fixed_texture_background_color
			row.background:SetVertexColor (c[1], c[2], c[3], c[4])
		else
			local c = self.row_info.fixed_texture_background_color
			local r, g, b = row.background:GetVertexColor()
			row.background:SetVertexColor (r, g, b, c[4])
		end
	
		--> outline
		if (left_text_outline) then
			_detalhes:SetFontOutline (row.texto_esquerdo, left_text_outline)
		else
			_detalhes:SetFontOutline (row.texto_esquerdo, nil)
		end
		
		if (right_text_outline) then
			self:SetFontOutline (row.texto_direita, right_text_outline)
		else
			self:SetFontOutline (row.texto_direita, nil)
		end
		
		--> texture:
		row.textura:SetTexture (self.row_info.texture_file)
		row.background:SetTexture (self.row_info.texture_background_file)
		
		--> texture class color: if true color changes on the fly through class refresh
		if (not texture_class_color) then
			row.textura:SetVertexColor (texture_r, texture_g, texture_b, alpha)
		else
			local r, g, b = row.textura:GetVertexColor()
			row.textura:SetVertexColor (r, g, b, alpha)
		end
		
		--> text class color: if true color changes on the fly through class refresh
		if (not left_text_class_color) then
			row.texto_esquerdo:SetTextColor (text_r, text_g, text_b)
		end
		if (not right_text_class_color) then
			row.texto_direita:SetTextColor (text_r, text_g, text_b)
		end
		
		--> text size
		_detalhes:SetFontSize (row.texto_esquerdo, self.row_info.font_size or height * 0.75)
		_detalhes:SetFontSize (row.texto_direita, self.row_info.font_size or height * 0.75)
		
		--> text font
		_detalhes:SetFontFace (row.texto_esquerdo, self.row_info.font_face_file or "GameFontHighlight")
		_detalhes:SetFontFace (row.texto_direita, self.row_info.font_face_file or "GameFontHighlight")

	end
	
	self:SetBarGrowDirection()

end

-- search key: ~wallpaper
function _detalhes:InstanceWallpaper (texture, anchor, alpha, texcoord, width, height, overlay)

	local wallpaper = self.wallpaper
	
	if (type (texture) == "boolean" and texture) then
		texture, anchor, alpha, texcoord, width, height, overlay = wallpaper.texture, wallpaper.anchor, wallpaper.alpha, wallpaper.texcoord, wallpaper.width, wallpaper.height, wallpaper.overlay
		
	elseif (type (texture) == "boolean" and not texture) then
		self.wallpaper.enabled = false
		return gump:Fade (self.baseframe.wallpaper, "in")
		
	elseif (type (texture) == "table") then
		anchor = texture.anchor or wallpaper.anchor
		alpha = texture.alpha or wallpaper.alpha
		if (texture.texcoord) then
			texcoord = {unpack (texture.texcoord)}
		else
			texcoord = wallpaper.texcoord
		end
		width = texture.width or wallpaper.width
		height = texture.height or wallpaper.height
		if (texture.overlay) then
			overlay = {unpack (texture.overlay)}
		else
			overlay = wallpaper.overlay
		end
		
		if (type (texture.enabled) == "boolean") then
			if (not texture.enabled) then
				wallpaper.enabled = false
				wallpaper.texture = texture.texture or wallpaper.texture
				wallpaper.anchor = anchor
				wallpaper.alpha = alpha
				wallpaper.texcoord = texcoord
				wallpaper.width = width
				wallpaper.height = height
				wallpaper.overlay = overlay
				return self:InstanceWallpaper (false)
			end
		end
		
		texture = texture.texture or wallpaper.texture

	else
		texture = texture or wallpaper.texture
		anchor = anchor or wallpaper.anchor
		alpha = alpha or wallpaper.alpha
		texcoord = texcoord or wallpaper.texcoord
		width = width or wallpaper.width
		height = height or wallpaper.height
		overlay = overlay or wallpaper.overlay
	end
	
	if (not wallpaper.texture and not texture) then
		local spec = GetSpecialization()
		if (spec) then
			local _, _, _, _, _background = GetSpecializationInfo (spec)
			if (_background) then
				texture = "Interface\\TALENTFRAME\\".._background
			end
		end
		
		texcoord = {0, 1, 0, 0.7}
		alpha = 0.5
		width, height = self:GetSize()
		anchor = "all"
	end
	
	local t = self.baseframe.wallpaper

	t:ClearAllPoints()
	
	if (anchor == "all") then
		t:SetPoint ("topleft", self.baseframe, "topleft")
		t:SetPoint ("bottomright", self.baseframe, "bottomright")
	elseif (anchor == "center") then
		t:SetPoint ("center", self.baseframe, "center", 0, 4)
	elseif (anchor == "stretchLR") then
		t:SetPoint ("center", self.baseframe, "center")
		t:SetPoint ("left", self.baseframe, "left")
		t:SetPoint ("right", self.baseframe, "right")
	elseif (anchor == "stretchTB") then
		t:SetPoint ("center", self.baseframe, "center")
		t:SetPoint ("top", self.baseframe, "top")
		t:SetPoint ("bottom", self.baseframe, "bottom")
	else
		t:SetPoint (anchor, self.baseframe, anchor)
	end
	
	t:SetTexture (texture)
	t:SetAlpha (alpha)
	t:SetTexCoord (unpack (texcoord))
	t:SetWidth (width)
	t:SetHeight (height)
	t:SetVertexColor (unpack (overlay))
	
	wallpaper.enabled = true
	wallpaper.texture = texture
	wallpaper.anchor = anchor
	wallpaper.alpha = alpha
	wallpaper.texcoord = texcoord
	wallpaper.width = width
	wallpaper.height = height
	wallpaper.overlay = overlay

	if (t.faded) then
		gump:Fade (t, "out")
	else
		gump:Fade (t, "AlphaAnim", alpha)
	end
end

function _detalhes:SetWindowAlpha (alpha, run_instance_color)
	local current_alpha = self.window_alpha or 1

	if (current_alpha > alpha) then
		gump:Fade (self.baseframe, "ALPHAANIM", alpha)
	else
		gump:Fade (self.baseframe, "ALPHAANIM", alpha)
	end

	gump:Fade (self.baseframe.cabecalho.ball, "ALPHAANIM", alpha)
	gump:Fade (self.baseframe.cabecalho.atributo_icon, "ALPHAANIM", alpha)
	
	self.window_alpha = alpha
	
	if (run_instance_color) then
		self:InstanceColor()
	end
end

function _detalhes:InstanceColor (red, green, blue, alpha, no_save)

	if (not red) then
		red, green, blue, alpha = unpack (self.color)
	end

	if (type (red) ~= "number") then
		red, green, blue, alpha = gump:ParseColors (red)
	end

	if (not no_save) then
		self.color [1] = red
		self.color [2] = green
		self.color [3] = blue
		self.color [4] = alpha
	end
	
	local skin = _detalhes.skins [self.skin]
	
	self.baseframe.rodape.esquerdo:SetVertexColor (red, green, blue)
		self.baseframe.rodape.esquerdo:SetAlpha (alpha)
	self.baseframe.rodape.direita:SetVertexColor (red, green, blue)
		self.baseframe.rodape.direita:SetAlpha (alpha)
	self.baseframe.rodape.top_bg:SetVertexColor (red, green, blue)
		self.baseframe.rodape.top_bg:SetAlpha (alpha)
	
	self.baseframe.cabecalho.ball_r:SetVertexColor (red, green, blue)
		self.baseframe.cabecalho.ball_r:SetAlpha (alpha)
	self.baseframe.cabecalho.ball:SetVertexColor (red, green, blue)
		if (skin.can_change_alpha_head) then
			self.baseframe.cabecalho.ball:SetAlpha (alpha)
		end
	self.baseframe.cabecalho.emenda:SetVertexColor (red, green, blue)
		self.baseframe.cabecalho.emenda:SetAlpha (alpha)
	self.baseframe.cabecalho.top_bg:SetVertexColor (red, green, blue)
		self.baseframe.cabecalho.top_bg:SetAlpha (alpha)

	self.baseframe.barra_esquerda:SetVertexColor (red, green, blue)
		self.baseframe.barra_esquerda:SetAlpha (alpha)
	self.baseframe.barra_direita:SetVertexColor (red, green, blue)
		self.baseframe.barra_direita:SetAlpha (alpha)
	self.baseframe.barra_fundo:SetVertexColor (red, green, blue)
		self.baseframe.barra_fundo:SetAlpha (alpha)
		
	self.color[1], self.color[2], self.color[3], self.color[4] = red, green, blue, alpha
end

function _detalhes:StatusBarAlertTime (instance)
	instance.baseframe.statusbar:Hide()
end

function _detalhes:StatusBarAlert (text, icon, color, time)

	local statusbar = self.baseframe.statusbar
	
	if (text) then
		if (type (text) == "table") then
			if (text.color) then
				statusbar.text:SetTextColor (gump:ParseColors (text.color))
			else
				statusbar.text:SetTextColor (1, 1, 1, 1)
			end
			
			statusbar.text:SetText (text.text or "")
			
			if (text.size) then
				_detalhes:SetFontSize (statusbar.text, text.size)
			else
				_detalhes:SetFontSize (statusbar.text, 9)
			end
		else
			statusbar.text:SetText (text)
			statusbar.text:SetTextColor (1, 1, 1, 1)
			_detalhes:SetFontSize (statusbar.text, 9)
		end
	else
		statusbar.text:SetText ("")
	end
	
	if (icon) then
		if (type (icon) == "table") then
			local texture, w, h, l, r, t, b = unpack (icon)
			statusbar.icon:SetTexture (texture)
			statusbar.icon:SetWidth (w or 14)
			statusbar.icon:SetHeight (h or 14)
			if (l and r and t and b) then
				statusbar.icon:SetTexCoord (l, r, t, b)
			end
		else
			statusbar.icon:SetTexture (icon)
			statusbar.icon:SetWidth (14)
			statusbar.icon:SetHeight (14)
			statusbar.icon:SetTexCoord (0, 1, 0, 1)
		end
	else
		statusbar.icon:SetTexture (nil)
	end
	
	if (color) then
		statusbar:SetBackdropColor (gump:ParseColors (color))
	else
		statusbar:SetBackdropColor (0, 0, 0, 1)
	end
	
	if (icon or text) then
		statusbar:Show()
		if (time) then
			_detalhes:ScheduleTimer ("StatusBarAlertTime", time, self)
		end
	else
		statusbar:Hide()
	end
end

function _detalhes:SetCloseButtonSettings (overlaycolor)
	if (overlaycolor == "reset") then
		overlaycolor = {1, 1, 1, 1}
	end

	if (overlaycolor) then
		local r, g, b, a = gump:ParseColors (overlaycolor)
		self.closebutton_info.color_overlay [1] = r
		self.closebutton_info.color_overlay [2] = g
		self.closebutton_info.color_overlay [3] = b
		self.closebutton_info.color_overlay [4] = a
	end

	local r, g, b, a = unpack (self.closebutton_info.color_overlay)
	self.baseframe.cabecalho.fechar:GetNormalTexture():SetVertexColor (r, g, b, a)
	self.baseframe.cabecalho.fechar:GetPushedTexture():SetVertexColor (r, g, b, a)
	self.baseframe.cabecalho.fechar:GetHighlightTexture():SetVertexColor (r, g, b, a)
end

function _detalhes:SetInstanceButtonSettings (textfont, textsize, textcolor, overlaycolor)

	if (textfont == "reset") then
		textfont = "Friz Quadrata TT"
		textsize = 12
		textcolor = {1, 0.81, 0, 1}
		overlaycolor = {1, 1, 1, 1}
	end
	
	--> text color
	if (textcolor) then
		local r, g, b, a = gump:ParseColors (textcolor)
		self.instancebutton_info.text_color [1] = r
		self.instancebutton_info.text_color [2] = g
		self.instancebutton_info.text_color [3] = b
		self.instancebutton_info.text_color [4] = a
	end
	
	_G [self.baseframe.cabecalho.novo:GetName().."Text"]:SetTextColor (unpack (self.instancebutton_info.text_color))
	
	--> text font
	if (textfont) then
		self.instancebutton_info.text_face = textfont
	end
	
	local font = SharedMedia:Fetch ("font", self.instancebutton_info.text_face)
	_detalhes:SetFontFace (_G [self.baseframe.cabecalho.novo:GetName().."Text"], font)
	
	--> text size
	if (textsize) then
		self.instancebutton_info.text_size = textsize
	end
	
	_detalhes:SetFontSize (_G [self.baseframe.cabecalho.novo:GetName().."Text"], self.instancebutton_info.text_size)
	
	--> overlay color
	if (overlaycolor) then
		local r, g, b, a = gump:ParseColors (overlaycolor)
		self.instancebutton_info.color_overlay [1] = r
		self.instancebutton_info.color_overlay [2] = g
		self.instancebutton_info.color_overlay [3] = b
		self.instancebutton_info.color_overlay [4] = a
	end

	local r, g, b, a = unpack (self.instancebutton_info.color_overlay)
	self.baseframe.cabecalho.novo.Left:SetVertexColor (r, g, b, a)
	self.baseframe.cabecalho.novo.Middle:SetVertexColor (r, g, b, a)
	self.baseframe.cabecalho.novo.Right:SetVertexColor (r, g, b, a)
end

function _detalhes:SetDeleteButtonSettings (textfont, textsize, textcolor, overlaycolor, alwaysminimized, smalltextcolor)
	
	if (textfont == "reset") then
		--print ("text color:", _G.DetailsResetButton1Text:GetTextColor())
		--print ("text font:", _detalhes:GetFontFace (_G.DetailsResetButton1Text))
		--print ("text size:", _detalhes:GetFontSize (_G.DetailsResetButton1Text))
		--print ("vertex color", _detalhes.ResetButton.Left:GetVertexColor())
		textfont = "Friz Quadrata TT"
		textsize = 12
		textcolor = {1, 0.81, 0, 1}
		smalltextcolor = {1, 0.81, 0, 1}
		overlaycolor = {1, 1, 1, 1}
		alwaysminimized = false
	end

	--> text color
	if (textcolor) then
		local r, g, b, a = gump:ParseColors (textcolor)
		self.resetbutton_info.text_color [1] = r
		self.resetbutton_info.text_color [2] = g
		self.resetbutton_info.text_color [3] = b
		self.resetbutton_info.text_color [4] = a
	end
	
	if (smalltextcolor) then
		local r, g, b, a = gump:ParseColors (smalltextcolor)
		self.resetbutton_info.text_color_small [1] = r
		self.resetbutton_info.text_color_small [2] = g
		self.resetbutton_info.text_color_small [3] = b
		self.resetbutton_info.text_color_small [4] = a
	end
	
	if (not self.resetbutton_info.text_color_small) then
		self.resetbutton_info.text_color_small = {1, 0.81, 0, 1}
	end
	
	if (_detalhes.ResetButtonInstance == self.meu_id) then
		_G.DetailsResetButton1Text:SetTextColor (unpack (self.resetbutton_info.text_color))
		_G.DetailsResetButton2Text2:SetTextColor (unpack (self.resetbutton_info.text_color_small))
	end
	
	--> text font
	if (textfont) then
		self.resetbutton_info.text_face = textfont
	end
	
	local font = SharedMedia:Fetch ("font", self.resetbutton_info.text_face)
	_detalhes:SetFontFace (_G.DetailsResetButton1Text, font)
	_detalhes:SetFontFace (_G.DetailsResetButton2Text2, font)
	
	--> text size
	if (textsize) then
		self.resetbutton_info.text_size = textsize
	end
	
	_detalhes:SetFontSize (_G.DetailsResetButton1Text, self.resetbutton_info.text_size)
	_detalhes:SetFontSize (_G.DetailsResetButton2Text2, self.resetbutton_info.text_size)
	
	--> overlay color
	if (overlaycolor) then
		local r, g, b, a = gump:ParseColors (overlaycolor)
		self.resetbutton_info.color_overlay [1] = r
		self.resetbutton_info.color_overlay [2] = g
		self.resetbutton_info.color_overlay [3] = b
		self.resetbutton_info.color_overlay [4] = a
	end
	
	if (_detalhes.ResetButtonInstance == self.meu_id) then
		local r, g, b, a = unpack (self.resetbutton_info.color_overlay)
		_detalhes.ResetButton.Left:SetVertexColor (r, g, b, a)
		_detalhes.ResetButton.Middle:SetVertexColor (r, g, b, a)
		_detalhes.ResetButton.Right:SetVertexColor (r, g, b, a)
		_detalhes.ResetButton2.Left:SetVertexColor (r, g, b, a)
		_detalhes.ResetButton2.Middle:SetVertexColor (r, g, b, a)
		_detalhes.ResetButton2.Right:SetVertexColor (r, g, b, a)
	end
	
	--> always minimized
	if (type (alwaysminimized) == "boolean") then
		self.resetbutton_info.always_small = alwaysminimized
	end
	
	self:ReajustaGump()
end


function gump:CriaRodape (baseframe, instancia)

	baseframe.rodape = {}
	
	--> esquerdo
	baseframe.rodape.esquerdo = baseframe.cabecalho.fechar:CreateTexture (nil, "overlay")
	baseframe.rodape.esquerdo:SetPoint ("topright", baseframe, "bottomleft", 16, 0)
	baseframe.rodape.esquerdo:SetTexture (DEFAULT_SKIN)
	baseframe.rodape.esquerdo:SetTexCoord (unpack (COORDS_PIN_LEFT))
	baseframe.rodape.esquerdo:SetWidth (32)
	baseframe.rodape.esquerdo:SetHeight (32)
	
	--> direito
	baseframe.rodape.direita = baseframe.cabecalho.fechar:CreateTexture (nil, "overlay")
	baseframe.rodape.direita:SetPoint ("topleft", baseframe, "bottomright", -16, 0)
	baseframe.rodape.direita:SetTexture (DEFAULT_SKIN)
	baseframe.rodape.direita:SetTexCoord (unpack (COORDS_PIN_RIGHT))
	baseframe.rodape.direita:SetWidth (32)
	baseframe.rodape.direita:SetHeight (32)
	
	--> barra centro
	baseframe.rodape.top_bg = baseframe:CreateTexture (nil, "background")
	baseframe.rodape.top_bg:SetTexture (DEFAULT_SKIN)
	baseframe.rodape.top_bg:SetTexCoord (unpack (COORDS_BOTTOM_BACKGROUND))
	baseframe.rodape.top_bg:SetWidth (512)
	baseframe.rodape.top_bg:SetHeight (128)
	baseframe.rodape.top_bg:SetPoint ("left", baseframe.rodape.esquerdo, "right", -16, -48)
	baseframe.rodape.top_bg:SetPoint ("right", baseframe.rodape.direita, "left", 16, -48)

	local StatusBarLeftAnchor = CreateFrame ("frame", nil, baseframe)
	StatusBarLeftAnchor:SetPoint ("left", baseframe.rodape.top_bg, "left", 5, 57)
	StatusBarLeftAnchor:SetWidth (1)
	StatusBarLeftAnchor:SetHeight (1)
	baseframe.rodape.StatusBarLeftAnchor = StatusBarLeftAnchor
	
	local StatusBarCenterAnchor = CreateFrame ("frame", nil, baseframe)
	StatusBarCenterAnchor:SetPoint ("center", baseframe.rodape.top_bg, "center", 0, 57)
	StatusBarCenterAnchor:SetWidth (1)
	StatusBarCenterAnchor:SetHeight (1)
	baseframe.rodape.StatusBarCenterAnchor = StatusBarCenterAnchor
	
	--> display frame
		baseframe.statusbar = CreateFrame ("frame", nil, baseframe.cabecalho.fechar)
		baseframe.statusbar:SetFrameLevel (baseframe.cabecalho.fechar:GetFrameLevel()+2)
		baseframe.statusbar:SetPoint ("left", baseframe.rodape.esquerdo, "right", -13, 10)
		baseframe.statusbar:SetPoint ("right", baseframe.rodape.direita, "left", 13, 10)
		baseframe.statusbar:SetHeight (14)
		
		local statusbar_icon = baseframe.statusbar:CreateTexture (nil, "overlay")
		statusbar_icon:SetWidth (14)
		statusbar_icon:SetHeight (14)
		statusbar_icon:SetPoint ("left", baseframe.statusbar, "left")
		
		local statusbar_text = baseframe.statusbar:CreateFontString (nil, "overlay", "GameFontNormal")
		statusbar_text:SetPoint ("left", statusbar_icon, "right", 2, 0)
		
		baseframe.statusbar:SetBackdrop ({
		bgFile = [[Interface\AddOns\Details\images\background]], tile = true, tileSize = 16,
		insets = {left = 0, right = 0, top = 0, bottom = 0}})
		baseframe.statusbar:SetBackdropColor (0, 0, 0, 1)
		
		baseframe.statusbar.icon = statusbar_icon
		baseframe.statusbar.text = statusbar_text
		baseframe.statusbar.instancia = instancia
		
		baseframe.statusbar:Hide()
	
	--> frame invis�vel
	baseframe.DOWNFrame = CreateFrame ("frame", nil, baseframe)
	baseframe.DOWNFrame:SetPoint ("left", baseframe.rodape.esquerdo, "right", 0, 10)
	baseframe.DOWNFrame:SetPoint ("right", baseframe.rodape.direita, "left", 0, 10)
	baseframe.DOWNFrame:SetHeight (14)
	
	baseframe.DOWNFrame:Show()
	baseframe.DOWNFrame:EnableMouse (true)
	baseframe.DOWNFrame:SetMovable (true)
	baseframe.DOWNFrame:SetResizable (true)
	
	BGFrame_scripts (baseframe.DOWNFrame, baseframe, instancia)
end

function _detalhes:CheckConsolidates()
	for meu_id, instancia in ipairs (_detalhes.tabela_instancias) do 
		if (instancia.consolidate and meu_id ~= _detalhes.lower_instance) then
			instancia:UnConsolidateIcons()
		end
	end
end

function _detalhes:ConsolidateIcons()

	self.consolidate = true
	
	self.consolidateButton:Show()
	
	self:DefaultIcons()
	
	return self:MenuAnchor()
end

function _detalhes:UnConsolidateIcons()

	self.consolidate = false
	
	if (not self.consolidateButton) then
		return self:DefaultIcons()
	end
	
	self.consolidateButton:Hide()
	
	self:DefaultIcons()
	
	return self:MenuAnchor()
end

--> search key: ~icon
function _detalhes:DefaultIcons (_mode, _segment, _attributes, _report)

	if (_mode == nil) then
		_mode = self.icons[1]
	end
	if (_segment == nil) then
		_segment = self.icons[2]
	end
	if (_attributes == nil) then
		_attributes = self.icons[3]
	end
	if (_report == nil) then
		_report = self.icons[4]
	end	

	if (self.consolidate and not self.consolidateButton:IsShown()) then
		self.consolidateButton:Show()
	elseif (not self.consolidate and self.consolidateButton:IsShown()) then
		self.consolidateButton:Hide()
	end

	local baseToolbar = self.baseframe.cabecalho
	local icons = {baseToolbar.modo_selecao, baseToolbar.segmento, baseToolbar.atributo, baseToolbar.report}
	local options = {_mode, _segment, _attributes, _report}
	local anchors = {{0, 0}, {0, 0}, {0, 0}, {-6, 0}}
	
	for index = 1, #icons do
		if (type (options[index]) == "boolean") then
			if (options[index]) then
				icons [index]:Show()
				self.icons[index] = true
			else
				icons [index]:Hide()
				self.icons[index] = false
			end
		end
	end

	local _gotFirst = false
	for index = 1, #icons do 
		local _thisIcon = icons [index]
		if (_thisIcon:IsShown()) then
			if (not _gotFirst) then
				
				_thisIcon:ClearAllPoints()

				if (self.consolidate) then
					_thisIcon:SetPoint ("topleft", self.consolidateFrame, "topleft", -3, -5)
					_thisIcon:SetParent (self.consolidateFrame)
				else
					_thisIcon:SetPoint ("bottomleft", baseToolbar.ball, "bottomright", anchors[index][1] + self.menu_anchor [1], anchors[index][2] + self.menu_anchor [2])
					_thisIcon:SetParent (self.baseframe)
					_thisIcon:SetFrameLevel (self.baseframe.UPFrame:GetFrameLevel()+1)

				end
				
				_gotFirst = true
			else
				for dex = index-1, 1, -1 do
					local _thisIcon2 = icons [dex]
					if (_thisIcon2:IsShown()) then
					
						_thisIcon:ClearAllPoints()
						
						if (self.consolidate) then
							_thisIcon:SetPoint ("topleft", _thisIcon2.widget or _thisIcon2, "bottomleft", anchors[index][1], anchors[index][2]-2)
							_thisIcon:SetParent (self.consolidateFrame)
						else
							_thisIcon:SetPoint ("left", _thisIcon2.widget or _thisIcon2, "right", 0 + anchors[index][1], 0 + anchors[index][2])
							_thisIcon:SetParent (self.baseframe)
							_thisIcon:SetFrameLevel (self.baseframe.UPFrame:GetFrameLevel()+1)
						end
						break
					end
				end
			end
		end
	end
	
	for index = #icons, 1, -1 do 
		if (icons [index]:IsShown()) then
			self.lastIcon = icons [index]
			break
		end
	end
	
	if (not self.lastIcon) then
		self.lastIcon = baseToolbar.ball
	end
	
	_detalhes.ToolBar:ReorganizeIcons()
	
	return true
end

local parameters_table = {}

local on_leave_menu = function (self, elapsed)
	parameters_table[2] = parameters_table[2] + elapsed
	if (parameters_table[2] > 0.3) then
		if (not _G.GameCooltip.mouseOver and not _G.GameCooltip.buttonOver) then
			_G.GameCooltip:ShowMe (false)
		end
		self:SetScript ("OnUpdate", nil)
	end
end

local build_mode_list = function (self, elapsed)

	local CoolTip = GameCooltip
	local instancia = parameters_table [1]
	parameters_table[2] = parameters_table[2] + elapsed
	
	if (parameters_table[2] > 0.15) then
		self:SetScript ("OnUpdate", nil)
		
		CoolTip:Reset()
		CoolTip:SetType ("menu")
		CoolTip:AddFromTable (parameters_table [4])
		CoolTip:SetLastSelected ("main", parameters_table [3])
		CoolTip:SetFixedParameter (instancia)
		CoolTip:SetColor ("main", "transparent")
		
		CoolTip:SetOption ("TextSize", _detalhes.font_sizes.menus)
		CoolTip:SetOption ("ButtonHeightMod", -5)
		CoolTip:SetOption ("ButtonsYMod", -5)
		CoolTip:SetOption ("YSpacingMod", 1)
		CoolTip:SetOption ("FixedHeight", 106)
		CoolTip:SetOption ("FixedWidthSub", 146)
		CoolTip:SetOption ("SubMenuIsTooltip", true)
		
		if (_detalhes.tutorial.logons > 9) then
			CoolTip:SetOption ("IgnoreSubMenu", true)
		end
		
		if (instancia.consolidate) then
			CoolTip:SetOwner (self, "topleft", "topright", 3)
		else
			if (instancia.toolbar_side == 1) then
				CoolTip:SetOwner (self)
			elseif (instancia.toolbar_side == 2) then --> bottom
				CoolTip:SetOwner (self, "bottom", "top", 0, -7)
			end
		end
		
		--CoolTip:SetWallpaper (1, [[Interface\ACHIEVEMENTFRAME\UI-Achievement-Parchment-Horizontal-Desaturated]], nil, {1, 1, 1, 0.3})
		CoolTip:SetWallpaper (1, [[Interface\SPELLBOOK\Spellbook-Page-1]], {.6, 0.1, 0, 0.64453125}, {1, 1, 1, 0.1}, true)
		
		CoolTip:ShowCooltip()
	end
end

local segments_used = 0
local segments_filled = 0
local empty_segment_color = {1, 1, 1, .4}

-- search key: ~segments
local build_segment_list = function (self, elapsed)

	local CoolTip = GameCooltip
	local instancia = parameters_table [1]
	parameters_table[2] = parameters_table[2] + elapsed
	
	if (parameters_table[2] > 0.15) then
		self:SetScript ("OnUpdate", nil)
	
		--> here we are using normal Add calls
		CoolTip:Reset()
		CoolTip:SetType ("menu")
		CoolTip:SetFixedParameter (instancia)
		CoolTip:SetColor ("main", "transparent")

		CoolTip:SetOption ("FixedWidthSub", 175)
		CoolTip:SetOption ("RightTextWidth", 105)
		CoolTip:SetOption ("RightTextHeight", 12)
		
		----------- segments
		local menuIndex = 0
		_detalhes.segments_amount = math.floor (_detalhes.segments_amount)
		
		local fight_amount = 0
		
		local filled_segments = 0
		for i = 1, _detalhes.segments_amount do
			if (_detalhes.tabela_historico.tabelas [i]) then
				filled_segments = filled_segments + 1
			else
				break
			end
		end

		filled_segments = _detalhes.segments_amount - filled_segments - 2
		local fill = math.abs (filled_segments - _detalhes.segments_amount)
		segments_used = 0
		segments_filled = fill
		
		for i = _detalhes.segments_amount, 1, -1 do
			
			if (i <= fill) then

				local thisCombat = _detalhes.tabela_historico.tabelas [i]
				if (thisCombat) then
					local enemy = thisCombat.is_boss and thisCombat.is_boss.name
					segments_used = segments_used + 1

					if (thisCombat.is_boss and thisCombat.is_boss.name) then
					
						if (thisCombat.is_boss.killed) then
							CoolTip:AddLine (thisCombat.is_boss.name .." (#"..i..")", _, 1, "lime")
						else
							CoolTip:AddLine (thisCombat.is_boss.name .." (#"..i..")", _, 1, "red")
						end
						
						local portrait = _detalhes:GetBossPortrait (thisCombat.is_boss.mapid, thisCombat.is_boss.index)
						if (portrait) then
							CoolTip:AddIcon (portrait, 2, "top", 128, 64)
						end
						CoolTip:AddIcon ([[Interface\AddOns\Details\images\icons]], "main", "left", 16, 16, 0.96875, 1, 0, 0.03125)
						
						local background = _detalhes:GetRaidIcon (thisCombat.is_boss.mapid)
						if (background) then
							CoolTip:SetWallpaper (2, background, nil, {1, 1, 1, 0.5})
						end
						
					else
						enemy = thisCombat.enemy
						if (enemy) then
							CoolTip:AddLine (thisCombat.enemy .." (#"..i..")", _, 1, "yellow")
						else
							CoolTip:AddLine (segmentos.past..i, _, 1, "silver")
						end
						
						if (thisCombat.is_trash) then
							CoolTip:AddIcon ([[Interface\AddOns\Details\images\icons]], "main", "left", 16, 12, 0.02734375, 0.11328125, 0.19140625, 0.3125)
						else
							CoolTip:AddIcon ([[Interface\QUESTFRAME\UI-Quest-BulletPoint]], "main", "left", 16, 16)
						end
						
						CoolTip:SetWallpaper (2, [[Interface\ACHIEVEMENTFRAME\UI-Achievement-StatsBackground]], {0.5078125, 0.1171875, 0.017578125, 0.1953125}, {1, 1, 1, .5})
						
					end
					
					CoolTip:AddMenu (1, instancia.TrocaTabela, i)
					
					CoolTip:AddLine (Loc ["STRING_SEGMENT_ENEMY"] .. ":", enemy, 2, "white", "white")
					
					local decorrido = (thisCombat.end_time or _detalhes._tempo) - thisCombat.start_time
					local minutos, segundos = _math_floor (decorrido/60), _math_floor (decorrido%60)
					CoolTip:AddLine (Loc ["STRING_SEGMENT_TIME"] .. ":", minutos.."m "..segundos.."s", 2, "white", "white")
					
					CoolTip:AddLine (Loc ["STRING_SEGMENT_START"] .. ":", thisCombat.data_inicio, 2, "white", "white")
					CoolTip:AddLine (Loc ["STRING_SEGMENT_END"] .. ":", thisCombat.data_fim or "in progress", 2, "white", "white")
					
					fight_amount = fight_amount + 1
				else
					CoolTip:AddLine (Loc ["STRING_SEGMENT_LOWER"] .. " #" .. i, _, 1, "gray")
					CoolTip:AddMenu (1, instancia.TrocaTabela, i)
					CoolTip:AddIcon ([[Interface\QUESTFRAME\UI-Quest-BulletPoint]], "main", "left", 16, 16, nil, nil, nil, nil, empty_segment_color)
					CoolTip:AddLine (Loc ["STRING_SEGMENT_EMPTY"], _, 2)
					CoolTip:AddIcon ([[Interface\CHARACTERFRAME\Disconnect-Icon]], 2, 1, 12, 12, 0.3125, 0.65625, 0.265625, 0.671875)
				end
				
				if (menuIndex) then
					menuIndex = menuIndex + 1
					if (instancia.segmento == i) then
						CoolTip:SetLastSelected ("main", menuIndex); 
						menuIndex = nil
					end
				end
			
			end
			
		end
		
		----------- current
		CoolTip:AddLine (segmentos.current_standard, _, 1, "white")
		CoolTip:AddMenu (1, instancia.TrocaTabela, 0)
		CoolTip:AddIcon ([[Interface\QUESTFRAME\UI-Quest-BulletPoint]], "main", "left", 16, 16, nil, nil, nil, nil, "orange")
			
			local enemy = _detalhes.tabela_vigente.is_boss and _detalhes.tabela_vigente.is_boss.name or _detalhes.tabela_vigente.enemy or "--x--x--"
			
			if (_detalhes.tabela_vigente.is_boss and _detalhes.tabela_vigente.is_boss.name) then
				local portrait = _detalhes:GetBossPortrait (_detalhes.tabela_vigente.is_boss.mapid, _detalhes.tabela_vigente.is_boss.index)
				if (portrait) then
					CoolTip:AddIcon (portrait, 2, "top", 128, 64)
				end
				
				local background = _detalhes:GetRaidIcon (_detalhes.tabela_vigente.is_boss.mapid)
				CoolTip:SetWallpaper (2, background, nil, {1, 1, 1, 0.5})
			else
				CoolTip:SetWallpaper (2, [[Interface\ACHIEVEMENTFRAME\UI-Achievement-StatsBackground]], {0.5078125, 0.1171875, 0.017578125, 0.1953125}, {1, 1, 1, .5})
			end					
			
			CoolTip:AddLine (Loc ["STRING_SEGMENT_ENEMY"] .. ":", enemy, 2, "white", "white")
			
			if (not _detalhes.tabela_vigente.end_time) then
				if (_detalhes.in_combat) then
					local decorrido = _detalhes._tempo - _detalhes.tabela_vigente.start_time
					local minutos, segundos = _math_floor (decorrido/60), _math_floor (decorrido%60)
					CoolTip:AddLine (Loc ["STRING_SEGMENT_TIME"] .. ":", minutos.."m "..segundos.."s", 2, "white", "white") 
				else
					CoolTip:AddLine (Loc ["STRING_SEGMENT_TIME"] .. ":", "--x--x--", 2, "white", "white")
				end
			else
				local decorrido = (_detalhes.tabela_vigente.end_time) - _detalhes.tabela_vigente.start_time
				local minutos, segundos = _math_floor (decorrido/60), _math_floor (decorrido%60)
				CoolTip:AddLine (Loc ["STRING_SEGMENT_TIME"] .. ":", minutos.."m "..segundos.."s", 2, "white", "white") 
			end

			
			CoolTip:AddLine (Loc ["STRING_SEGMENT_START"] .. ":", _detalhes.tabela_vigente.data_inicio, 2, "white", "white")
			CoolTip:AddLine (Loc ["STRING_SEGMENT_END"] .. ":", _detalhes.tabela_vigente.data_fim or "in progress", 2, "white", "white") 
		
			--> fill � a quantidade de menu que esta sendo mostrada
			if (instancia.segmento == 0) then
				if (fill - 2 == menuIndex) then
					CoolTip:SetLastSelected ("main", fill - 1)
				elseif (fill - 1 == menuIndex) then
					CoolTip:SetLastSelected ("main", fill)
				else
					CoolTip:SetLastSelected ("main", fill + 1)
				end

				menuIndex = nil
			end
		
		----------- overall
		--CoolTip:AddLine (segmentos.overall_standard, _, 1, "white") Loc ["STRING_REPORT_LAST"] .. " " .. fight_amount .. " " .. Loc ["STRING_REPORT_FIGHTS"]
		CoolTip:AddLine (Loc ["STRING_SEGMENT_OVERALL"], _, 1, "white")
		CoolTip:AddMenu (1, instancia.TrocaTabela, -1)
		CoolTip:AddIcon ([[Interface\QUESTFRAME\UI-Quest-BulletPoint]], "main", "left", 16, 16, nil, nil, nil, nil, "orange")
		
			CoolTip:AddLine (Loc ["STRING_SEGMENT_ENEMY"] .. ":", "--x--x--", 2, "white", "white")--localize-me
			
			if (not _detalhes.tabela_overall.end_time) then
				if (_detalhes.in_combat) then
					local decorrido = _detalhes._tempo - _detalhes.tabela_overall.start_time
					local minutos, segundos = _math_floor (decorrido/60), _math_floor (decorrido%60)
					CoolTip:AddLine (Loc ["STRING_SEGMENT_TIME"] .. ":", minutos.."m "..segundos.."s", 2, "white", "white") 
				else
					CoolTip:AddLine (Loc ["STRING_SEGMENT_TIME"] .. ":", "--x--x--", 2, "white", "white")
				end
			else
				local decorrido = (_detalhes.tabela_overall.end_time) - _detalhes.tabela_overall.start_time
				local minutos, segundos = _math_floor (decorrido/60), _math_floor (decorrido%60)
				CoolTip:AddLine (Loc ["STRING_SEGMENT_TIME"] .. ":", minutos.."m "..segundos.."s", 2, "white", "white") 
			end
			
			CoolTip:SetWallpaper (2, [[Interface\ACHIEVEMENTFRAME\UI-Achievement-StatsBackground]], {0.5078125, 0.1171875, 0.017578125, 0.1953125}, {1, 1, 1, .5})
			
			local earlyFight = ""
			for i = _detalhes.segments_amount, 1, -1 do
				if (_detalhes.tabela_historico.tabelas [i]) then
					earlyFight = _detalhes.tabela_historico.tabelas [i].data_inicio
					break
				end
			end
			CoolTip:AddLine (Loc ["STRING_SEGMENT_START"] .. ":", earlyFight, 2, "white", "white")
			
			local lastFight = ""
			for i = 1, _detalhes.segments_amount do
				if (_detalhes.tabela_historico.tabelas [i] and _detalhes.tabela_historico.tabelas [i].data_fim ~= 0) then
					lastFight = _detalhes.tabela_historico.tabelas [i].data_fim
					break
				end
			end
			CoolTip:AddLine (Loc ["STRING_SEGMENT_END"] .. ":", lastFight, 2, "white", "white")
			
			--> fill � a quantidade de menu que esta sendo mostrada
			if (instancia.segmento == -1) then
				if (fill - 2 == menuIndex) then
					CoolTip:SetLastSelected ("main", fill)
				elseif (fill - 1 == menuIndex) then
					CoolTip:SetLastSelected ("main", fill+1)
				else
					CoolTip:SetLastSelected ("main", fill + 2)
				end
				menuIndex = nil
			end
			
		---------------------------------------------
		
		if (instancia.consolidate) then
			CoolTip:SetOwner (self, "topleft", "topright", 3)
		else
			if (instancia.toolbar_side == 1) then
				CoolTip:SetOwner (self)
			elseif (instancia.toolbar_side == 2) then --> bottom
				CoolTip:SetOwner (self, "bottom", "top", 0, -7)
			end
		end
		
		CoolTip:SetOption ("TextSize", _detalhes.font_sizes.menus)
		CoolTip:SetOption ("SubMenuIsTooltip", true)
		
		CoolTip:SetOption ("ButtonHeightMod", -4)
		CoolTip:SetOption ("ButtonsYMod", -4)
		CoolTip:SetOption ("YSpacingMod", 4)
		
		CoolTip:SetOption ("ButtonHeightModSub", 4)
		CoolTip:SetOption ("ButtonsYModSub", 0)
		CoolTip:SetOption ("YSpacingModSub", -4)
		
		--CoolTip:SetWallpaper (1, [[Interface\ACHIEVEMENTFRAME\UI-Achievement-Parchment-Horizontal-Desaturated]], nil, {1, 1, 1, 0.3})
		CoolTip:SetWallpaper (1, [[Interface\SPELLBOOK\Spellbook-Page-1]], {.6, 0.1, 0, 0.64453125}, {1, 1, 1, 0.1}, true)
		
		CoolTip:ShowCooltip()
		
		self:SetScript ("OnUpdate", nil)
	end	
	
end

function _detalhes:DisableUIPanelButton (button)
	button.Right:Hide()
	button.Middle:Hide()
	
	button:SetScript ("OnMouseDown", function()
		button.Left:SetPoint ("topleft", button, "topleft", 1, -1)
		button.Left:SetPoint ("bottomleft", button, "bottomleft", 1, -1)
	end)
	
	button:SetScript ("OnMouseUp", function()
		button.Left:SetPoint ("topleft", button, "topleft")
		button.Left:SetPoint ("bottomleft", button, "bottomleft")
	end)
	button:SetScript ("OnShow", function()end)
	button:SetScript ("OnDisable", function()end)
	button:SetScript ("OnEnable", function()end)
end

function _detalhes:RestoreUIPanelButton (button)
	--> restaura o bot�o
	button.Left:SetTexture ([[Interface\Buttons\UI-Panel-Button-Down]])
	button.Left:SetTexCoord (0, 0.0937, 0, 0.6875)
	button.Left:SetSize (12, 22)
	button.Right:Show()
	button.Middle:Show()
	
	button:SetScript ("OnMouseDown", function (self)
		if ( self:IsEnabled() ) then
			self.Left:SetTexture([[Interface\Buttons\UI-Panel-Button-Down]]);
			self.Middle:SetTexture([[Interface\Buttons\UI-Panel-Button-Down]]);
			self.Right:SetTexture([[Interface\Buttons\UI-Panel-Button-Down]]);
		end
	end)
	
	button:SetScript ("OnMouseUp", function (self)
		if ( self:IsEnabled() ) then
			self.Left:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]]);
			self.Middle:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]]);
			self.Right:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]]);
		end
	end)
	
	button:SetScript ("OnShow", function (self)
		if ( self:IsEnabled() ) then
			self.Left:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]]);
			self.Middle:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]]);
			self.Right:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]]);
		end
	end)
	button:SetScript ("OnDisable", function (self)
		self.Left:SetTexture([[Interface\Buttons\UI-Panel-Button-Disabled]]);
		self.Middle:SetTexture([[Interface\Buttons\UI-Panel-Button-Disabled]]);
		self.Right:SetTexture([[Interface\Buttons\UI-Panel-Button-Disabled]]);
	end)
	button:SetScript ("OnEnable", function (self)
		self.Left:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]]);
		self.Middle:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]]);
		self.Right:SetTexture([[Interface\Buttons\UI-Panel-Button-Up]]);
	end)
end

local botao_fechar_on_enter = function (self)
	OnEnterMainWindow (self.instancia, self, 3)
end
local botao_fechar_on_leave = function (self)
	OnLeaveMainWindow (self.instancia, self, 3)
end

function SetCloseButtonAnchors (self, this_skin)
	if (self.toolbar_side == 1) then --top
	
		self.baseframe.cabecalho.fechar:SetScript ("OnMouseDown", function()
			self.baseframe.cabecalho.fechar:ClearAllPoints()
			self.baseframe.cabecalho.fechar:SetPoint ("bottomright", self.baseframe, "topright", this_skin.close_button_anchor[1]+1, this_skin.close_button_anchor[2]-1)
		end)
		
		self.baseframe.cabecalho.fechar:SetScript ("OnMouseUp", function()
			self.baseframe.cabecalho.fechar:ClearAllPoints()
			self.baseframe.cabecalho.fechar:SetPoint ("bottomright", self.baseframe, "topright", this_skin.close_button_anchor[1], this_skin.close_button_anchor[2])

			self.baseframe.cabecalho.fechar:Disable()
			self:DesativarInstancia() 

			if (_detalhes.opened_windows == 0) then
				print (Loc ["STRING_CLOSEALL"])
			end
		end)
	
	elseif (self.toolbar_side == 2) then --bottom
	
		self.baseframe.cabecalho.fechar:SetScript ("OnMouseDown", function()
			local y = 0
			if (self.show_statusbar) then
				y = -14
			end
		
			local _x, _y = unpack (this_skin.close_button_anchor_bottom)
			self.baseframe.cabecalho.fechar:ClearAllPoints()
			self.baseframe.cabecalho.fechar:SetPoint ("topright", self.baseframe, "bottomright", _x + 1, _y + y - 1)
		end)
		
		self.baseframe.cabecalho.fechar:SetScript ("OnMouseUp", function()
			local y = 0
			if (self.show_statusbar) then
				y = -14
			end
		
			local _x, _y = unpack (this_skin.close_button_anchor_bottom)
			self.baseframe.cabecalho.fechar:ClearAllPoints()
			self.baseframe.cabecalho.fechar:SetPoint ("topright", self.baseframe, "bottomright", _x, _y + y)

			self.baseframe.cabecalho.fechar:Disable()
			self:DesativarInstancia() 

			if (_detalhes.opened_windows == 0) then
				print (Loc ["STRING_CLOSEALL"])
			end
		end)
	
	end
end

-- ~skin
function _detalhes:ChangeSkin (skin_name)

	if (not skin_name) then
		skin_name = self.skin
	end

	local this_skin = _detalhes.skins [skin_name]

	if (not this_skin) then
		skin_name = "Default Skin"
		this_skin = _detalhes.skins [skin_name]
	end

	local just_updating = false
	if (self.skin == skin_name) then
		just_updating = true
	end

	if (not just_updating) then

		--> skin updater
		if (self.bgframe.skin_script) then
			self.bgframe:SetScript ("OnUpdate", nil)
			self.bgframe.skin_script = false
		end
	
		--> reset all config
			self:ResetInstanceConfig()
	
		--> reset instance button
			self:SetInstanceButtonSettings ("reset")
		
		--> reset delete button
			if (_detalhes.ResetButtonInstance == self.meu_id) then
				self:SetDeleteButtonSettings ("reset")
			end
			DetailsResetButton2Text2:SetText ("-")
			
		--> reset close button
			self:SetCloseButtonSettings ("reset")
	
		--> overwrites
			local overwrite_cprops = this_skin.instance_cprops
			if (overwrite_cprops) then
				
				local copy = table_deepcopy (overwrite_cprops)
				
				for cprop, value in _pairs (copy) do
					if (type (value) == "table") then
						for cprop2, value2 in _pairs (value) do
							self [cprop] [cprop2] = value2
						end
					else
						self [cprop] = value
					end
				end
				
			end
			
		--> reset instance button
			self:SetInstanceButtonSettings()
		--> reset delete button
			if (_detalhes.ResetButtonInstance == self.meu_id) then
				self:SetDeleteButtonSettings()
			end
		--> reset close button
			self:SetCloseButtonSettings ()
			
		--> reset micro frames
			_detalhes.StatusBar:Reset (self)

	end
	
	self.skin = skin_name

	local skin_file = this_skin.file

	--> set textures
		self.baseframe.cabecalho.ball:SetTexture (skin_file) --> bola esquerda
		self.baseframe.cabecalho.emenda:SetTexture (skin_file) --> emenda que liga a bola a textura do centro
		
		self.baseframe.cabecalho.ball_r:SetTexture (skin_file) --> bola direita onde fica o bot�o de fechar
		self.baseframe.cabecalho.top_bg:SetTexture (skin_file) --> top background
		
		self.baseframe.barra_esquerda:SetTexture (skin_file) --> barra lateral
		self.baseframe.barra_direita:SetTexture (skin_file) --> barra lateral
		self.baseframe.barra_fundo:SetTexture (skin_file) --> barra inferior
		
		self.baseframe.scroll_up:SetTexture (skin_file) --> scrollbar parte de cima
		self.baseframe.scroll_down:SetTexture (skin_file) --> scrollbar parte de baixo
		self.baseframe.scroll_middle:SetTexture (skin_file) --> scrollbar parte do meio
		
		self.baseframe.rodape.top_bg:SetTexture (skin_file) --> rodape top background
		self.baseframe.rodape.esquerdo:SetTexture (skin_file) --> rodape esquerdo
		self.baseframe.rodape.direita:SetTexture (skin_file) --> rodape direito
		
		self.baseframe.button_stretch.texture:SetTexture (skin_file) --> bot�o de esticar a janela
		
		self.baseframe.resize_direita.texture:SetTexture (skin_file) --> bot�o de redimencionar da direita
		self.baseframe.resize_esquerda.texture:SetTexture (skin_file) --> bot�o de redimencionar da esquerda
		
		self.botao_separar:SetNormalTexture (skin_file) --> cadeado
		self.botao_separar:SetDisabledTexture (skin_file)
		self.botao_separar:SetHighlightTexture (skin_file, "ADD")
		self.botao_separar:SetPushedTexture (skin_file)
		

----------> custom reset button
		if (this_skin.reset_button_coords) then
			if (_detalhes.ResetButtonInstance == self.meu_id) then
				--> seta o bot�o
				_detalhes.ResetButton.Left:SetTexture (skin_file)
				_detalhes.ResetButton.Left:SetTexCoord (unpack (this_skin.reset_button_coords))
				_detalhes.ResetButton.Left:SetSize (_detalhes.ResetButton:GetSize())
				
				_detalhes.ResetButton2.Left:SetTexture (skin_file)
				_detalhes.ResetButton2.Left:SetTexCoord (unpack (this_skin.reset_button_small_coords or this_skin.reset_button_coords))
				_detalhes.ResetButton2.Left:SetSize (_detalhes.ResetButton2:GetSize())
				
				--> remove propriedades do bot�o da blizzard
				_detalhes:DisableUIPanelButton (_detalhes.ResetButton)
				_detalhes:DisableUIPanelButton (_detalhes.ResetButton2)
			end
		else
			if (_detalhes.ResetButtonInstance == self.meu_id) then
				_detalhes:RestoreUIPanelButton (_detalhes.ResetButton)
				_detalhes:RestoreUIPanelButton (_detalhes.ResetButton2)
			end
		end

----------> custom instance button

	if (this_skin.instance_button_coords) then
		
		--> seta o bot�o
		self.baseframe.cabecalho.novo:SetHeight (12)
		self.baseframe.cabecalho.novo.Left:SetTexture (skin_file)
		self.baseframe.cabecalho.novo.Left:SetTexCoord (unpack (this_skin.instance_button_coords))
		self.baseframe.cabecalho.novo.Left:SetSize (self.baseframe.cabecalho.novo:GetSize())

		--> remove propriedades do bot�o da blizzard
		_detalhes:DisableUIPanelButton (self.baseframe.cabecalho.novo)
		
	else
		self.baseframe.cabecalho.novo:SetHeight (15)
		_detalhes:RestoreUIPanelButton (self.baseframe.cabecalho.novo)
	end
	
----------> custom close button

	if (this_skin.close_button_coords) then
	
		--> textures
		self.baseframe.cabecalho.fechar:SetDisabledTexture (skin_file)
		self.baseframe.cabecalho.fechar:SetNormalTexture (skin_file)
		self.baseframe.cabecalho.fechar:SetPushedTexture (skin_file)
		self.baseframe.cabecalho.fechar:SetHighlightTexture (skin_file)
		
		--> texcoords
		self.baseframe.cabecalho.fechar:GetDisabledTexture():SetTexCoord (unpack (this_skin.close_button_coords))
		self.baseframe.cabecalho.fechar:GetNormalTexture():SetTexCoord (unpack (this_skin.close_button_coords))
		self.baseframe.cabecalho.fechar:GetPushedTexture():SetTexCoord (unpack (this_skin.close_button_coords))
		self.baseframe.cabecalho.fechar:GetHighlightTexture():SetTexCoord (unpack (this_skin.close_button_coords))
		
		--> if the custom close button have a specified size
		if (this_skin.close_button_size) then
			self.baseframe.cabecalho.fechar:SetSize (unpack (this_skin.close_button_size))
		else
			self.baseframe.cabecalho.fechar:SetSize (18, 18)
		end
		
		SetCloseButtonAnchors (self, this_skin)

	else
		self.baseframe.cabecalho.fechar:SetDisabledTexture ([[Interface\Buttons\UI-Panel-MinimizeButton-Disabled]])
		self.baseframe.cabecalho.fechar:SetNormalTexture ([[Interface\Buttons\UI-Panel-MinimizeButton-Up]])
		self.baseframe.cabecalho.fechar:SetPushedTexture ([[Interface\Buttons\UI-Panel-MinimizeButton-Down]])
		self.baseframe.cabecalho.fechar:SetHighlightTexture ([[Interface\Buttons\UI-Panel-MinimizeButton-Highlight]])
		
		self.baseframe.cabecalho.fechar:GetDisabledTexture():SetTexCoord (0, 1, 0, 1)
		self.baseframe.cabecalho.fechar:GetNormalTexture():SetTexCoord (0, 1, 0, 1)
		self.baseframe.cabecalho.fechar:GetPushedTexture():SetTexCoord (0, 1, 0, 1)
		self.baseframe.cabecalho.fechar:GetHighlightTexture():SetTexCoord (0, 1, 0, 1)
		
		self.baseframe.cabecalho.fechar:SetScript ("OnMouseDown", nil)
		self.baseframe.cabecalho.fechar:SetScript ("OnMouseUp", nil)
		
		if (this_skin.close_button_size) then
			self.baseframe.cabecalho.fechar:SetSize (unpack (this_skin.close_button_size))
		else
			self.baseframe.cabecalho.fechar:SetSize (32, 32)
		end
	end

----------> customize micro frames
	
	if (this_skin.micro_frames) then
		if (this_skin.micro_frames.color) then
			_detalhes.StatusBar:ApplyOptions (self.StatusBar.left, "textcolor", this_skin.micro_frames.color)
			_detalhes.StatusBar:ApplyOptions (self.StatusBar.center, "textcolor", this_skin.micro_frames.color)
			_detalhes.StatusBar:ApplyOptions (self.StatusBar.right, "textcolor", this_skin.micro_frames.color)
		end
		if (this_skin.micro_frames.font) then
			_detalhes.StatusBar:ApplyOptions (self.StatusBar.left, "textface", this_skin.micro_frames.font)
			_detalhes.StatusBar:ApplyOptions (self.StatusBar.center, "textface", this_skin.micro_frames.font)
			_detalhes.StatusBar:ApplyOptions (self.StatusBar.right, "textface", this_skin.micro_frames.font)
		end
		if (this_skin.micro_frames.size) then
			_detalhes.StatusBar:ApplyOptions (self.StatusBar.left, "textsize", this_skin.micro_frames.size)
			_detalhes.StatusBar:ApplyOptions (self.StatusBar.center, "textsize", this_skin.micro_frames.size)
			_detalhes.StatusBar:ApplyOptions (self.StatusBar.right, "textsize", this_skin.micro_frames.size)
		end
	end
	
----------> icon anchor and size
	
	if (self.modo == 1 or self.modo == 4 or self.atributo == 5) then -- alone e raid
		local icon_anchor = this_skin.icon_anchor_plugins
		self.baseframe.cabecalho.atributo_icon:SetPoint ("topright", self.baseframe.cabecalho.ball_point, "topright", icon_anchor[1], icon_anchor[2])
		if (self.modo == 1) then
			if (_detalhes.SoloTables.Plugins [1] and _detalhes.SoloTables.Mode) then
				local plugin_index = _detalhes.SoloTables.Mode
				if (plugin_index > 0 and _detalhes.SoloTables.Menu [plugin_index]) then
					self:ChangeIcon (_detalhes.SoloTables.Menu [plugin_index] [2])
				end
			end

		elseif (self.modo == 4) then
			if (_detalhes.RaidTables.Plugins [1] and _detalhes.RaidTables.Mode) then
				local plugin_index = _detalhes.RaidTables.Mode
				if (plugin_index and _detalhes.RaidTables.Menu [plugin_index]) then
					self:ChangeIcon (_detalhes.RaidTables.Menu [plugin_index] [2])
				end
			end
		end
	else
		local icon_anchor = this_skin.icon_anchor_main --> ancora do icone do canto direito superior
		self.baseframe.cabecalho.atributo_icon:SetPoint ("topright", self.baseframe.cabecalho.ball_point, "topright", icon_anchor[1], icon_anchor[2])
		self:ChangeIcon()
	end
	
----------> lock alpha head	
	
	if (not this_skin.can_change_alpha_head) then
		self.baseframe.cabecalho.ball:SetAlpha (100)
	else
		self.baseframe.cabecalho.ball:SetAlpha (self.color[4])
	end
	
----------> call widgets handlers	
		self:SetBarSettings (self.row_info.height)
	
	--> refresh instance button
		self:SetInstanceButtonSettings()
	
	--> refresh delete button
		if (_detalhes.ResetButtonInstance == self.meu_id) then
			self:SetDeleteButtonSettings()
		end
		
	--> refresh close button
		self:SetCloseButtonSettings()
	
	--> update toolbar
		self:ToolbarSide() -- aqui
	
	--> update stretch button
		self:StretchButtonAnchor()
	
	--> update side bars
		if (self.show_sidebars) then
			self:ShowSideBars()
		else
			self:HideSideBars()
		end

	--> update statusbar
		if (self.show_statusbar) then
			self:ShowStatusBar() -- aqui
		else
			self:HideStatusBar()
		end
	
	--> update wallpaper
		if (self.wallpaper.enabled) then
			self:InstanceWallpaper (true)
		else
			self:InstanceWallpaper (false)
		end
	
	--> update instance color
		self:InstanceColor()
		self:SetBackgroundColor()
		self:SetBackgroundAlpha()
	
	--> refresh all bars
		self:InstanceRefreshRows()
	
	--> update menu saturation
		self:DesaturateMenu()
	
	--> refresh options panel if opened
		if (_G.DetailsOptionsWindow and _G.DetailsOptionsWindow:IsShown()) then
			--print (self.meu_id)
			_detalhes:OpenOptionsWindow (self)
		end
	
	if (not just_updating or _detalhes.initializing) then
		if (this_skin.callback) then
			this_skin:callback (self)
		end
		
		if (this_skin.control_script) then
			if (this_skin.control_script_on_start) then
				this_skin:control_script_on_start (self)
			end
			self.bgframe:SetScript ("OnUpdate", this_skin.control_script)
			self.bgframe.skin_script = true
			self.bgframe.skin = this_skin
			--self.bgframe.skin_script_instance = true
		end
		
	end
	
end

function _detalhes:ToolbarSide (side)
	
	if (not side) then
		side = self.toolbar_side
	end
	
	self.toolbar_side = side
	
	local skin = _detalhes.skins [self.skin]
	
	if (side == 1) then --> top
		--> ball point
		self.baseframe.cabecalho.ball_point:ClearAllPoints()
		self.baseframe.cabecalho.ball_point:SetPoint ("bottomleft", self.baseframe, "topleft", unpack (skin.icon_point_anchor))
		--> ball
		self.baseframe.cabecalho.ball:SetTexCoord (unpack (COORDS_LEFT_BALL))
		self.baseframe.cabecalho.ball:ClearAllPoints()
		self.baseframe.cabecalho.ball:SetPoint ("bottomleft", self.baseframe, "topleft", unpack (skin.left_corner_anchor))
		--> bot�o fechar
		self.baseframe.cabecalho.fechar:ClearAllPoints()
		self.baseframe.cabecalho.fechar:SetPoint ("bottomright", self.baseframe, "topright", unpack (skin.close_button_anchor))
		if (skin.close_button_coords) then
			SetCloseButtonAnchors (self, skin)
		end
		--> ball r
		self.baseframe.cabecalho.ball_r:SetTexCoord (unpack (COORDS_RIGHT_BALL))
		self.baseframe.cabecalho.ball_r:ClearAllPoints()
		self.baseframe.cabecalho.ball_r:SetPoint ("bottomright", self.baseframe, "topright", unpack (skin.right_corner_anchor))
		
		--> instance
		self:InstanceButtonAnchor()

		--> tex coords
		self.baseframe.cabecalho.emenda:SetTexCoord (unpack (COORDS_LEFT_CONNECTOR))
		self.baseframe.cabecalho.top_bg:SetTexCoord (unpack (COORDS_TOP_BACKGROUND))
		
		--> menu
		self:MenuAnchor()

		
	else --> bottom
	
		local y = 0
		if (self.show_statusbar) then
			y = -14
		end
	
		--> ball point
		self.baseframe.cabecalho.ball_point:ClearAllPoints()
		local _x, _y = unpack (skin.icon_point_anchor_bottom)
		self.baseframe.cabecalho.ball_point:SetPoint ("topleft", self.baseframe, "bottomleft", _x, _y + y)
		--> ball
		self.baseframe.cabecalho.ball:ClearAllPoints()
		local _x, _y = unpack (skin.left_corner_anchor_bottom)
		self.baseframe.cabecalho.ball:SetPoint ("topleft", self.baseframe, "bottomleft", _x, _y + y)
		local l, r, t, b = unpack (COORDS_LEFT_BALL)
		self.baseframe.cabecalho.ball:SetTexCoord (l, r, b, t)
		--> bot�o fechar
		self.baseframe.cabecalho.fechar:ClearAllPoints()
		local _x, _y = unpack (skin.close_button_anchor_bottom)
		self.baseframe.cabecalho.fechar:SetPoint ("topright", self.baseframe, "bottomright", _x, _y + y)
		if (skin.close_button_coords) then
			SetCloseButtonAnchors (self, skin)
		end
		--> ball r
		self.baseframe.cabecalho.ball_r:ClearAllPoints()
		local _x, _y = unpack (skin.right_corner_anchor_bottom)
		self.baseframe.cabecalho.ball_r:SetPoint ("topright", self.baseframe, "bottomright", _x, _y + y)
		local l, r, t, b = unpack (COORDS_RIGHT_BALL)
		self.baseframe.cabecalho.ball_r:SetTexCoord (l, r, b, t)
		
		--> tex coords
		local l, r, t, b = unpack (COORDS_LEFT_CONNECTOR)
		self.baseframe.cabecalho.emenda:SetTexCoord (l, r, b, t)
		local l, r, t, b = unpack (COORDS_TOP_BACKGROUND)
		self.baseframe.cabecalho.top_bg:SetTexCoord (l, r, b, t)
		
		--> instance button
		self:InstanceButtonAnchor()
		
		--> menu buttons
		self:MenuAnchor()
	end
	
	self:StretchButtonAnchor()
	
	self:HideMainIcon()
	
	if (self.show_sidebars) then
		self:ShowSideBars()
	end
	
end

function _detalhes:StretchButtonAnchor (side)
	
	if (not side) then
		side = self.stretch_button_side
	end
	
	if (side == 1 or string.lower (side) == "top") then
	
		self.baseframe.button_stretch:ClearAllPoints()
		
		local y = 0
		if (self.toolbar_side == 2) then --bottom
			y = -20
		end
		
		self.baseframe.button_stretch:SetPoint ("bottom", self.baseframe, "top", 0, 20 + y)
		self.baseframe.button_stretch:SetPoint ("right", self.baseframe, "right", -27, 0)
		self.baseframe.button_stretch.texture:SetTexCoord (unpack (COORDS_STRETCH))
		self.stretch_button_side = 1
		
	elseif (side == 2 or string.lower (side) == "bottom") then
	
		self.baseframe.button_stretch:ClearAllPoints()
		
		local y = 0
		if (self.toolbar_side == 2) then --bottom
			y = y -20
		end
		if (self.show_statusbar) then
			y = y -14
		end
		
		self.baseframe.button_stretch:SetPoint ("center", self.baseframe, "center")
		self.baseframe.button_stretch:SetPoint ("top", self.baseframe, "bottom", 0, y)
		
		local l, r, t, b = unpack (COORDS_STRETCH)
		self.baseframe.button_stretch.texture:SetTexCoord (r, l, b, t)
		
		self.stretch_button_side = 2
		
	end
	
end

function _detalhes:InstanceButtonAnchor (x, y)

	if (not x) then
		x = self.instance_button_anchor [1]
	end
	if (not y) then
		y = self.instance_button_anchor [2]
	end

	self.instance_button_anchor [1] = x
	self.instance_button_anchor [2] = y

	self.baseframe.cabecalho.novo:ClearAllPoints()
	
	if (self.toolbar_side == 2) then --> bottom
		local y_mod = 0
		if (self.show_statusbar) then
			y_mod = 14
		end
		self.baseframe.cabecalho.novo:SetPoint ("topright", self.baseframe, "bottomright", x, (y + y_mod) * -1)
	else
		self.baseframe.cabecalho.novo:SetPoint ("bottomright", self.baseframe, "topright", x, y)
	end

end

function _detalhes:MenuAnchor (x, y)

	if (not x) then
		x = self.menu_anchor [1]
	end
	if (not y) then
		y = self.menu_anchor [2]
	end

	self.menu_anchor [1] = x
	self.menu_anchor [2] = y
	
	if (self.consolidate) then
		self.consolidateButton:ClearAllPoints()
		
		if (self.toolbar_side == 1) then --> top
			self.consolidateButton:SetPoint ("bottomleft", self.baseframe.cabecalho.ball, "bottomright", x, y)
			
		else --> bottom
		
			self.consolidateButton:SetPoint ("topleft", self.baseframe.cabecalho.ball, "topright", x, y*-1)
		end
		
	else --> not consolidated
		self.baseframe.cabecalho.modo_selecao:ClearAllPoints()
	
		if (self.toolbar_side == 1) then --> top
			self.baseframe.cabecalho.modo_selecao:SetPoint ("bottomleft", self.baseframe.cabecalho.ball, "bottomright", x, y)
			
		else --> bottom
			self.baseframe.cabecalho.modo_selecao:SetPoint ("topleft", self.baseframe.cabecalho.ball, "topright", x, y*-1)

		end
	end
end

function _detalhes:HideMainIcon (value)

	if (type (value) ~= "boolean") then
		value = self.hide_icon
	end

	if (value) then
	
		self.hide_icon = true
		gump:Fade (self.baseframe.cabecalho.atributo_icon, 1)
		--self.baseframe.cabecalho.ball:SetParent (self.baseframe)
		
		if (self.toolbar_side == 1) then
			self.baseframe.cabecalho.ball:SetTexCoord (unpack (COORDS_LEFT_BALL_NO_ICON))
			self.baseframe.cabecalho.emenda:SetTexCoord (unpack (COORDS_LEFT_CONNECTOR_NO_ICON))
			
		elseif (self.toolbar_side == 2) then
			local l, r, t, b = unpack (COORDS_LEFT_BALL_NO_ICON)
			self.baseframe.cabecalho.ball:SetTexCoord (l, r, b, t)
			local l, r, t, b = unpack (COORDS_LEFT_CONNECTOR_NO_ICON)
			self.baseframe.cabecalho.emenda:SetTexCoord (l, r, b, t)
		
		end
		
	else
		self.hide_icon = false
		gump:Fade (self.baseframe.cabecalho.atributo_icon, 0)
		--self.baseframe.cabecalho.ball:SetParent (_detalhes.listener)
		
		if (self.toolbar_side == 1) then

			self.baseframe.cabecalho.ball:SetTexCoord (unpack (COORDS_LEFT_BALL))
			self.baseframe.cabecalho.emenda:SetTexCoord (unpack (COORDS_LEFT_CONNECTOR))
			
		elseif (self.toolbar_side == 2) then

			local l, r, t, b = unpack (COORDS_LEFT_BALL)
			self.baseframe.cabecalho.ball:SetTexCoord (l, r, b, t)
			local l, r, t, b = unpack (COORDS_LEFT_CONNECTOR)
			self.baseframe.cabecalho.emenda:SetTexCoord (l, r, b, t)
		end
	end
	
end

--> search key: ~desaturate
function _detalhes:DesaturateMenu (value)

	if (value == nil) then
		value = self.desaturated_menu
	end

	if (value) then
	
		self.desaturated_menu = true
		self.baseframe.cabecalho.modo_selecao:GetNormalTexture():SetDesaturated (true)
		self.baseframe.cabecalho.segmento:GetNormalTexture():SetDesaturated (true)
		self.baseframe.cabecalho.atributo:GetNormalTexture():SetDesaturated (true)
		self.baseframe.cabecalho.report:GetNormalTexture():SetDesaturated (true)
		
		if (self.meu_id == _detalhes:GetLowerInstanceNumber()) then
			for _, button in _ipairs (_detalhes.ToolBar.AllButtons) do
				button:GetNormalTexture():SetDesaturated (true)
			end
		end
		
	else
	
		self.desaturated_menu = false
		self.baseframe.cabecalho.modo_selecao:GetNormalTexture():SetDesaturated (false)
		self.baseframe.cabecalho.segmento:GetNormalTexture():SetDesaturated (false)
		self.baseframe.cabecalho.atributo:GetNormalTexture():SetDesaturated (false)
		self.baseframe.cabecalho.report:GetNormalTexture():SetDesaturated (false)
		
		if (self.meu_id == _detalhes:GetLowerInstanceNumber()) then
			for _, button in _ipairs (_detalhes.ToolBar.AllButtons) do
				button:GetNormalTexture():SetDesaturated (false)
			end
		end
		
	end
end

function _detalhes:ShowSideBars (instancia)
	if (instancia) then
		self = instancia
	end
	
	self.show_sidebars = true
	
	self.baseframe.barra_esquerda:Show()
	self.baseframe.barra_direita:Show()
	
	--> set default spacings
	local this_skin = _detalhes.skins [self.skin]
	if (this_skin.instance_cprops and this_skin.instance_cprops.row_info and this_skin.instance_cprops.row_info.space) then
		self.row_info.space.left = this_skin.instance_cprops.row_info.space.left
		self.row_info.space.right = this_skin.instance_cprops.row_info.space.right
	else
		self.row_info.space.left = 3
		self.row_info.space.right = -5
	end

	if (self.show_statusbar) then
		self.baseframe.barra_esquerda:SetPoint ("bottomleft", self.baseframe, "bottomleft", -56, -14)
		self.baseframe.barra_direita:SetPoint ("bottomright", self.baseframe, "bottomright", 56, -14)
		
		if (self.toolbar_side == 2) then
			self.baseframe.barra_fundo:Show()
			local l, r, t, b = unpack (COORDS_BOTTOM_SIDE_BAR)
			self.baseframe.barra_fundo:SetTexCoord (l, r, b, t)
			self.baseframe.barra_fundo:ClearAllPoints()
			self.baseframe.barra_fundo:SetPoint ("bottomleft", self.baseframe, "topleft", 0, -6)
			self.baseframe.barra_fundo:SetPoint ("bottomright", self.baseframe, "topright", -1, -6)
		else
			self.baseframe.barra_fundo:Hide()
		end
	else
		self.baseframe.barra_esquerda:SetPoint ("bottomleft", self.baseframe, "bottomleft", -56, 0)
		self.baseframe.barra_direita:SetPoint ("bottomright", self.baseframe, "bottomright", 56, 0)
		
		self.baseframe.barra_fundo:Show()
		
		if (self.toolbar_side == 2) then --tooltbar on bottom
			local l, r, t, b = unpack (COORDS_BOTTOM_SIDE_BAR)
			self.baseframe.barra_fundo:SetTexCoord (l, r, b, t)
			self.baseframe.barra_fundo:ClearAllPoints()
			self.baseframe.barra_fundo:SetPoint ("bottomleft", self.baseframe, "topleft", 0, -6)
			self.baseframe.barra_fundo:SetPoint ("bottomright", self.baseframe, "topright", -1, -6)
		else --tooltbar on top
			self.baseframe.barra_fundo:SetTexCoord (unpack (COORDS_BOTTOM_SIDE_BAR))
			self.baseframe.barra_fundo:ClearAllPoints()
			self.baseframe.barra_fundo:SetPoint ("bottomleft", self.baseframe, "bottomleft", 0, -56)
			self.baseframe.barra_fundo:SetPoint ("bottomright", self.baseframe, "bottomright", -1, -56)
		end
	end
	
	self:SetBarGrowDirection()
	
end

function _detalhes:HideSideBars (instancia)
	if (instancia) then
		self = instancia
	end
	
	self.show_sidebars = false
	
	self.row_info.space.left = 0
	self.row_info.space.right = 0
	
	self.baseframe.barra_esquerda:Hide()
	self.baseframe.barra_direita:Hide()
	self.baseframe.barra_fundo:Hide()
	
	self:SetBarGrowDirection()
end

function _detalhes:HideStatusBar (instancia)
	if (instancia) then
		self = instancia
	end
	
	self.show_statusbar = false
	
	self.baseframe.rodape.esquerdo:Hide()
	self.baseframe.rodape.direita:Hide()
	self.baseframe.rodape.top_bg:Hide()
	self.baseframe.rodape.StatusBarLeftAnchor:Hide()
	self.baseframe.rodape.StatusBarCenterAnchor:Hide()
	
	if (self.toolbar_side == 2) then
		self:ToolbarSide()
	end
	
	if (self.show_sidebars) then
		self:ShowSideBars()
	end
	
	self:StretchButtonAnchor()
	
	_detalhes.StatusBar:Hide (self) --> mini displays widgets
end

function _detalhes:ShowStatusBar (instancia)
	if (instancia) then
		self = instancia
	end
	
	self.show_statusbar = true
	
	self.baseframe.rodape.esquerdo:Show()
	self.baseframe.rodape.direita:Show()
	self.baseframe.rodape.top_bg:Show()
	self.baseframe.rodape.StatusBarLeftAnchor:Show()
	self.baseframe.rodape.StatusBarCenterAnchor:Show()
	
	self:ToolbarSide()
	self:StretchButtonAnchor()
	
	_detalhes.StatusBar:Show (self) --> mini displays widgets
end

function gump:CriaCabecalho (baseframe, instancia)

-- texturas da barra superior
------------------------------------------------------------------------------------------------------------------------------------------------- 	
	
	baseframe.cabecalho = {}
	
	--> FECHAR INSTANCIA ----------------------------------------------------------------------------------------------------------------------------------------------------
	baseframe.cabecalho.fechar = CreateFrame ("button", nil, baseframe, "UIPanelCloseButton")
	baseframe.cabecalho.fechar:SetWidth (32)
	baseframe.cabecalho.fechar:SetHeight (32)
	baseframe.cabecalho.fechar:SetFrameLevel (5) --> altura mais alta que os demais frames
	baseframe.cabecalho.fechar:SetPoint ("bottomright", baseframe, "topright", 5, -6) --> seta o ponto dele fixando no base frame
	
	baseframe.cabecalho.fechar:SetScript ("OnClick", function() 
		baseframe.cabecalho.fechar:Disable()
		instancia:DesativarInstancia() 
		--> n�o h� mais inst�ncias abertas, ent�o manda msg alertando
		if (_detalhes.opened_windows == 0) then
			print (Loc ["STRING_CLOSEALL"])
		end
	end)
	
	baseframe.cabecalho.fechar.instancia = instancia
	baseframe.cabecalho.fechar:SetText ("x")
	baseframe.cabecalho.fechar:SetScript ("OnEnter", botao_fechar_on_enter)
	baseframe.cabecalho.fechar:SetScript ("OnLeave", botao_fechar_on_leave)	

	--> bola do canto esquedo superior --> primeiro criar a arma��o para apoiar as texturas
	baseframe.cabecalho.ball_point = baseframe.cabecalho.fechar:CreateTexture (nil, "overlay")
	baseframe.cabecalho.ball_point:SetPoint ("bottomleft", baseframe, "topleft", -37, 0)
	baseframe.cabecalho.ball_point:SetWidth (64)
	baseframe.cabecalho.ball_point:SetHeight (32)
	
	--> icone do atributo
	--baseframe.cabecalho.atributo_icon = _detalhes.listener:CreateTexture (nil, "artwork")
	baseframe.cabecalho.atributo_icon = baseframe:CreateTexture (nil, "background")
	local icon_anchor = _detalhes.skins ["Default Skin"].icon_anchor_main
	baseframe.cabecalho.atributo_icon:SetPoint ("topright", baseframe.cabecalho.ball_point, "topright", icon_anchor[1], icon_anchor[2])
	baseframe.cabecalho.atributo_icon:SetTexture (DEFAULT_SKIN)
	baseframe.cabecalho.atributo_icon:SetWidth (32)
	baseframe.cabecalho.atributo_icon:SetHeight (32)
	
	--> bola overlay
	--baseframe.cabecalho.ball = _detalhes.listener:CreateTexture (nil, "overlay")
	baseframe.cabecalho.ball = baseframe:CreateTexture (nil, "overlay")
	baseframe.cabecalho.ball:SetPoint ("bottomleft", baseframe, "topleft", -107, 0)
	baseframe.cabecalho.ball:SetWidth (128)
	baseframe.cabecalho.ball:SetHeight (128)
	
	baseframe.cabecalho.ball:SetTexture (DEFAULT_SKIN)
	baseframe.cabecalho.ball:SetTexCoord (unpack (COORDS_LEFT_BALL))

	--> emenda
	baseframe.cabecalho.emenda = baseframe:CreateTexture (nil, "background")
	baseframe.cabecalho.emenda:SetPoint ("bottomleft", baseframe.cabecalho.ball, "bottomright")
	baseframe.cabecalho.emenda:SetWidth (8)
	baseframe.cabecalho.emenda:SetHeight (128)
	baseframe.cabecalho.emenda:SetTexture (DEFAULT_SKIN)
	baseframe.cabecalho.emenda:SetTexCoord (unpack (COORDS_LEFT_CONNECTOR))

	baseframe.cabecalho.atributo_icon:Hide()
	baseframe.cabecalho.ball:Hide()

	--> bola do canto direito superior
	baseframe.cabecalho.ball_r = baseframe:CreateTexture (nil, "background")
	baseframe.cabecalho.ball_r:SetPoint ("bottomright", baseframe, "topright", 96, 0)
	baseframe.cabecalho.ball_r:SetWidth (128)
	baseframe.cabecalho.ball_r:SetHeight (128)
	baseframe.cabecalho.ball_r:SetTexture (DEFAULT_SKIN)
	baseframe.cabecalho.ball_r:SetTexCoord (unpack (COORDS_RIGHT_BALL))

	--> barra centro
	baseframe.cabecalho.top_bg = baseframe:CreateTexture (nil, "background")
	baseframe.cabecalho.top_bg:SetPoint ("left", baseframe.cabecalho.emenda, "right", 0, 0)
	baseframe.cabecalho.top_bg:SetPoint ("right", baseframe.cabecalho.ball_r, "left")
	baseframe.cabecalho.top_bg:SetTexture (DEFAULT_SKIN)
	baseframe.cabecalho.top_bg:SetTexCoord (unpack (COORDS_TOP_BACKGROUND))
	baseframe.cabecalho.top_bg:SetWidth (512)
	baseframe.cabecalho.top_bg:SetHeight (128)

	--> frame invis�vel
	baseframe.UPFrame = CreateFrame ("frame", "DetailsUpFrameInstance"..instancia.meu_id, baseframe)
	baseframe.UPFrame:SetPoint ("left", baseframe.cabecalho.ball, "right", 0, -53)
	baseframe.UPFrame:SetPoint ("right", baseframe.cabecalho.ball_r, "left", 0, -53)
	baseframe.UPFrame:SetHeight (20)
	
	baseframe.UPFrame:Show()
	baseframe.UPFrame:EnableMouse (true)
	baseframe.UPFrame:SetMovable (true)
	baseframe.UPFrame:SetResizable (true)
	
	BGFrame_scripts (baseframe.UPFrame, baseframe, instancia)
	
	
-- bot�es	
------------------------------------------------------------------------------------------------------------------------------------------------- 	

	local CoolTip = _G.GameCooltip

	--> SELE��O DO MODO ----------------------------------------------------------------------------------------------------------------------------------------------------
	
	baseframe.cabecalho.modo_selecao = gump:NewButton (baseframe, nil, "DetailsModeButton"..instancia.meu_id, nil, 16, 16, _detalhes.empty_function, nil, nil, [[Interface\GossipFrame\HealerGossipIcon]])
	baseframe.cabecalho.modo_selecao:SetPoint ("bottomleft", baseframe.cabecalho.ball, "bottomright", instancia.menu_anchor [1], instancia.menu_anchor [2])
	baseframe.cabecalho.modo_selecao:SetFrameLevel (baseframe:GetFrameLevel()+5)
	
	--> Generating Cooltip menu from table template
	local modeMenuTable = {
	
		{text = Loc ["STRING_MODE_GROUP"]},
		{func = instancia.AlteraModo, param1 = 2},
		{icon = [[Interface\AddOns\Details\images\modo_icones]], l = 32/256, r = 32/256*2, t = 0, b = 1, width = 20, height = 20},
		{text = Loc ["STRING_HELP_MODEGROUP"], type = 2},
		{icon = [[Interface\TUTORIALFRAME\TutorialFrame-QuestionMark]], type = 2, width = 16, height = 16, l = 8/64, r = 1 - (8/64), t = 8/64, b = 1 - (8/64)},

		{text = Loc ["STRING_MODE_ALL"]},
		{func = instancia.AlteraModo, param1 = 3},
		{icon = [[Interface\AddOns\Details\images\modo_icones]], l = 32/256*2, r = 32/256*3, t = 0, b = 1, width = 20, height = 20},
		{text = Loc ["STRING_HELP_MODEALL"], type = 2},
		{icon = [[Interface\TUTORIALFRAME\TutorialFrame-QuestionMark]], type = 2, width = 16, height = 16, l = 8/64, r = 1 - (8/64), t = 8/64, b = 1 - (8/64)},		
	
		{text = Loc ["STRING_MODE_SELF"] .. " (|cffa0a0a0" .. Loc ["STRING_MODE_PLUGINS"] .. "|r)"},
		{func = instancia.AlteraModo, param1 = 1},
		{icon = [[Interface\AddOns\Details\images\modo_icones]], l = 0, r = 32/256, t = 0, b = 1, width = 20, height = 20},
		{text = Loc ["STRING_HELP_MODESELF"], type = 2},
		{icon = [[Interface\TUTORIALFRAME\TutorialFrame-QuestionMark]], type = 2, width = 16, height = 16, l = 8/64, r = 1 - (8/64), t = 8/64, b = 1 - (8/64)},

		{text = Loc ["STRING_MODE_RAID"] .. " (|cffa0a0a0" .. Loc ["STRING_MODE_PLUGINS"] .. "|r)"},
		{func = instancia.AlteraModo, param1 = 4},
		{icon = [[Interface\AddOns\Details\images\modo_icones]], l = 32/256*3, r = 32/256*4, t = 0, b = 1, width = 20, height = 20},
		{text = Loc ["STRING_HELP_MODERAID"], type = 2},
		{icon = [[Interface\TUTORIALFRAME\TutorialFrame-QuestionMark]], type = 2, width = 16, height = 16, l = 8/64, r = 1 - (8/64), t = 8/64, b = 1 - (8/64)},
		
		{text = Loc ["STRING_OPTIONS_WINDOW"]},
		{func = _detalhes.OpenOptionsWindow},
		{icon = [[Interface\AddOns\Details\images\modo_icones]], l = 32/256*4, r = 32/256*5, t = 0, b = 1, width = 20, height = 20},
	}
	
	--> Cooltip raw method for enter/leave show/hide
	baseframe.cabecalho.modo_selecao:SetScript ("OnEnter", function (self)
	
		--gump:Fade (baseframe.button_stretch, "alpha", 0.3)
		OnEnterMainWindow (instancia, self, 3)
		
		if (instancia.desaturated_menu) then
			self:GetNormalTexture():SetDesaturated (false)
		end
		
		_G.GameCooltip.buttonOver = true
		baseframe.cabecalho.button_mouse_over = true
		
		local passou = 0
		if (_G.GameCooltip.active) then
			passou = 0.15
		end

		local checked
		if (instancia.modo == 1) then
			checked = 3
		elseif (instancia.modo == 2) then
			checked = 1
		elseif (instancia.modo == 3) then
			checked = 2
		elseif (instancia.modo == 4) then
			checked = 4
		end

		parameters_table [1] = instancia
		parameters_table [2] = passou
		parameters_table [3] = checked
		parameters_table [4] = modeMenuTable
		
		self:SetScript ("OnUpdate", build_mode_list)
	end)
	
	baseframe.cabecalho.modo_selecao:SetScript ("OnLeave", function (self) 
		OnLeaveMainWindow (instancia, self, 3)
		
		if (instancia.desaturated_menu) then
			self:GetNormalTexture():SetDesaturated (true)
		end
		
		_G.GameCooltip.buttonOver = false
		baseframe.cabecalho.button_mouse_over = false
		
		if (_G.GameCooltip.active) then
			parameters_table [2] = 0
			self:SetScript ("OnUpdate", on_leave_menu)
		else
			self:SetScript ("OnUpdate", nil)
		end
	end)
	
	--> SELECIONAR O SEGMENTO  ----------------------------------------------------------------------------------------------------------------------------------------------------
	baseframe.cabecalho.segmento = gump:NewButton (baseframe, nil, "DetailsSegmentButton"..instancia.meu_id, nil, 16, 16, _detalhes.empty_function, nil, nil, [[Interface\GossipFrame\TrainerGossipIcon]])
	baseframe.cabecalho.segmento:SetFrameLevel (baseframe.UPFrame:GetFrameLevel()+1)

	baseframe.cabecalho.segmento:SetHook ("OnMouseUp", function (button, buttontype)

		if (buttontype == "LeftButton") then
		
			local segmento_goal = instancia.segmento + 1
			if (segmento_goal > segments_used) then
				segmento_goal = -1
			elseif (segmento_goal > _detalhes.segments_amount) then
				segmento_goal = -1
			end
			
			local total_shown = segments_filled+2
			local goal = segmento_goal+1
			
			local select_ = math.abs (goal - total_shown)
			GameCooltip:Select (1, select_)
			
			return instancia:TrocaTabela (segmento_goal)
		elseif (buttontype == "RightButton") then
		
			local segmento_goal = instancia.segmento - 1
			if (segmento_goal < -1) then
				segmento_goal = segments_used
			end
			
			local total_shown = segments_filled+2
			local goal = segmento_goal+1
			
			local select_ = math.abs (goal - total_shown)
			GameCooltip:Select (1, select_)
			
			return instancia:TrocaTabela (segmento_goal)
		
		elseif (buttontype == "MiddleButton") then
			
			local segmento_goal = 0
			
			local total_shown = segments_filled+2
			local goal = segmento_goal+1
			
			local select_ = math.abs (goal - total_shown)
			GameCooltip:Select (1, select_)
			
			return instancia:TrocaTabela (segmento_goal)
			
		end
	end)
	baseframe.cabecalho.segmento:SetPoint ("left", baseframe.cabecalho.modo_selecao, "right", 0, 0)

	--> Cooltip raw method for show/hide onenter/onhide
	baseframe.cabecalho.segmento:SetScript ("OnEnter", function (self) 
		--gump:Fade (baseframe.button_stretch, "alpha", 0.3)
		OnEnterMainWindow (instancia, self, 3)
		
		if (instancia.desaturated_menu) then
			self:GetNormalTexture():SetDesaturated (false)
		end
		
		_G.GameCooltip.buttonOver = true
		baseframe.cabecalho.button_mouse_over = true
		
		local passou = 0
		if (_G.GameCooltip.active) then
			passou = 0.15
		end

		parameters_table [1] = instancia
		parameters_table [2] = passou
		self:SetScript ("OnUpdate", build_segment_list)
	end)
	
	--> Cooltip raw method
	baseframe.cabecalho.segmento:SetScript ("OnLeave", function (self) 
		--gump:Fade (baseframe.button_stretch, -1)
		OnLeaveMainWindow (instancia, self, 3)
		
		if (instancia.desaturated_menu) then
			self:GetNormalTexture():SetDesaturated (true)
		end
		
		_G.GameCooltip.buttonOver = false
		baseframe.cabecalho.button_mouse_over = false
		
		if (_G.GameCooltip.active) then
			parameters_table [2] = 0
			self:SetScript ("OnUpdate", on_leave_menu)
		else
			self:SetScript ("OnUpdate", nil)
		end
	end)	

	--> SELECIONAR O ATRIBUTO  ----------------------------------------------------------------------------------------------------------------------------------------------------
	baseframe.cabecalho.atributo = gump:NewDetailsButton (baseframe, _, instancia, instancia.TrocaTabela, instancia, -3, 16, 16, [[Interface\AddOns\Details\images\sword]])
	baseframe.cabecalho.atributo:SetFrameLevel (baseframe.UPFrame:GetFrameLevel()+1)
	baseframe.cabecalho.atributo:SetPoint ("left", baseframe.cabecalho.segmento.widget, "right", 0, 0)

	--> Cooltip automatic method through Injection
	
	--> First we declare the function which will build the menu
	local BuildAttributeMenu = function()
		if (_detalhes.solo and _detalhes.solo == instancia.meu_id) then
			return _detalhes:MontaSoloOption (instancia)
		elseif (_detalhes.raid and _detalhes.raid == instancia.meu_id) then
			return _detalhes:MontaRaidOption (instancia)
		else
			return _detalhes:MontaAtributosOption (instancia)
		end
	end
	
	--> Now we create a table with some parameters
	--> your frame need to have a member called CoolTip
	baseframe.cabecalho.atributo.CoolTip = {
		Type = "menu", --> the type, menu tooltip tooltipbars
		BuildFunc = BuildAttributeMenu, --> called when user mouse over the frame
		OnEnterFunc = function (self) 
			baseframe.cabecalho.button_mouse_over = true; 
			OnEnterMainWindow (instancia, baseframe.cabecalho.atributo, 3) 
			if (instancia.desaturated_menu) then
				self:GetNormalTexture():SetDesaturated (false)
			end
		end,
		OnLeaveFunc = function (self) 
			baseframe.cabecalho.button_mouse_over = false; 
			OnLeaveMainWindow (instancia, baseframe.cabecalho.atributo, 3) 
			if (instancia.desaturated_menu) then
				self:GetNormalTexture():SetDesaturated (true)
			end
		end,
		FixedValue = instancia,
		ShowSpeed = 0.15,
		Options = function()
			if (instancia.consolidate) then
				return {Anchor = instancia.consolidateFrame, MyAnchor = "topleft", RelativeAnchor = "topright", TextSize = _detalhes.font_sizes.menus}
			else
				if (instancia.toolbar_side == 1) then --top
					return {TextSize = _detalhes.font_sizes.menus}
				elseif (instancia.toolbar_side == 2) then --bottom
					return {TextSize = _detalhes.font_sizes.menus, HeightAnchorMod = -7}
				end
			end
		end}
	
	--> install cooltip
	_G.GameCooltip:CoolTipInject (baseframe.cabecalho.atributo)

	--> REPORTAR ~report ----------------------------------------------------------------------------------------------------------------------------------------------------
			baseframe.cabecalho.report = gump:NewDetailsButton (baseframe, _, instancia, _detalhes.Reportar, instancia, nil, 16, 16, [[Interface\COMMON\VOICECHAT-ON]])
			baseframe.cabecalho.report:SetPoint ("left", baseframe.cabecalho.atributo, "right", -6, 0)
			baseframe.cabecalho.report:SetFrameLevel (baseframe.UPFrame:GetFrameLevel()+1)
			baseframe.cabecalho.report:SetScript ("OnEnter", function (self)
				OnEnterMainWindow (instancia, self, 3)
				if (instancia.desaturated_menu) then
					self:GetNormalTexture():SetDesaturated (false)
				end
				
				GameCooltip:Reset()
				GameCooltip:AddLine (Loc ["STRING_REPORT_BUTTON_TOOLTIP"])
				GameCooltip:SetOwner (baseframe.cabecalho.report)
				GameCooltip:SetWallpaper (1, [[Interface\SPELLBOOK\Spellbook-Page-1]], {.6, 0.1, 0, 0.64453125}, {1, 1, 1, 0.1}, true)
				GameCooltip:Show()
				
			end)
			baseframe.cabecalho.report:SetScript ("OnLeave", function (self)
				OnLeaveMainWindow (instancia, self, 3)
				if (instancia.desaturated_menu) then
					self:GetNormalTexture():SetDesaturated (true)
				end
				GameCooltip:Hide()
			end)

	--> NOVA INSTANCIA ----------------------------------------------------------------------------------------------------------------------------------------------------
	baseframe.cabecalho.novo = CreateFrame ("button", "DetailsInstanceButton"..instancia.meu_id, baseframe, "OptionsButtonTemplate")
	baseframe.cabecalho.novo:SetFrameLevel (baseframe.UPFrame:GetFrameLevel()+1)
	
	baseframe.cabecalho.novo:SetWidth (30)
	baseframe.cabecalho.novo:SetHeight (15)

	baseframe.cabecalho.novo:SetPoint ("bottomright", baseframe, "topright", instancia.instance_button_anchor [1], instancia.instance_button_anchor [2])
	
	baseframe.cabecalho.novo:SetScript ("OnClick", function() _detalhes:CriarInstancia (_, true); _G.GameCooltip:ShowMe (false) end)
	baseframe.cabecalho.novo:SetText ("#"..instancia.meu_id)

	--> cooltip through inject
	--> OnClick Function [1] caller [2] fixed param [3] param1 [4] param2
	local OnClickNovoMenu = function (_, _, id)
		_detalhes.CriarInstancia (_, _, id)
		_G.GameCooltip:ExecFunc (baseframe.cabecalho.novo)
	end
	
	--> Build Menu Function
	local BuildClosedInstanceMenu = function() 
	
		local ClosedInstances = {}
		
		for index = 1, #_detalhes.tabela_instancias, 1 do 
		
			local _this_instance = _detalhes.tabela_instancias [index]
			
			if (not _this_instance.ativa) then --> s� reabre se ela estiver ativa
			
				--> pegar o que ela ta mostrando
				local atributo = _this_instance.atributo
				local sub_atributo = _this_instance.sub_atributo
				
				if (atributo == 5) then --> custom
				
					local CustomObject = _detalhes.custom [sub_atributo]
					
					--> as addmenu dont support textcoords we need to add in parts, first adding text and menu, after we add the icon
					--> text and menu can be added in one call if doesnt need more details like color or right text
					CoolTip:AddMenu (1, OnClickNovoMenu, index, nil, nil, "#".. index .. " " .. _detalhes.atributos.lista [atributo] .. " - " .. CustomObject.name, _, true)
					CoolTip:AddIcon (CustomObject.icon, 1, 1, 20, 20, 0, 1, 0, 1)
					
				else
					local modo = _this_instance.modo
					
					if (modo == 1) then --alone
					
						atributo = _detalhes.SoloTables.Mode or 1
						local SoloInfo = _detalhes.SoloTables.Menu [atributo]
						if (SoloInfo) then
							CoolTip:AddMenu (1, OnClickNovoMenu, index, nil, nil, "#".. index .. " " .. SoloInfo [1], _, true)
							CoolTip:AddIcon (SoloInfo [2], 1, 1, 20, 20, 0, 1, 0, 1)
						else
							CoolTip:AddMenu (1, OnClickNovoMenu, index, nil, nil, "#".. index .. " Unknown Plugin", _, true)
						end
						
					elseif (modo == 4) then --raid
					
						atributo = _detalhes.RaidTables.Mode or 1
						local RaidInfo = _detalhes.RaidTables.Menu [atributo]
						if (RaidInfo) then
							CoolTip:AddMenu (1, OnClickNovoMenu, index, nil, nil, "#".. index .. " " .. RaidInfo [1], _, true)
							CoolTip:AddIcon (RaidInfo [2], 1, 1, 20, 20, 0, 1, 0, 1)	
						else
							CoolTip:AddMenu (1, OnClickNovoMenu, index, nil, nil, "#".. index .. " Unknown Plugin", _, true)
						end
						
					else
					
						CoolTip:AddMenu (1, OnClickNovoMenu, index, nil, nil, "#".. index .. " " .. _detalhes.atributos.lista [atributo] .. " - " .. _detalhes.sub_atributos [atributo].lista [sub_atributo], _, true)
						CoolTip:AddIcon (_detalhes.sub_atributos [atributo].icones[sub_atributo] [1], 1, 1, 20, 20, unpack (_detalhes.sub_atributos [atributo].icones[sub_atributo] [2]))
					end
				end


			end
		end
		
		GameCooltip:SetWallpaper (1, [[Interface\SPELLBOOK\Spellbook-Page-1]], {.6, 0.1, 0, 0.64453125}, {1, 1, 1, 0.1}, true)
		
		return ClosedInstances
	end
	
	--> Inject Options Table
	baseframe.cabecalho.novo.CoolTip = { 
		--> cooltip type "menu" "tooltip" "tooltipbars"
		Type = "menu",
		--> how much time wait with mouse over the frame until cooltip show up
		ShowSpeed = 0.15,
		--> will call for build menu
		BuildFunc = BuildClosedInstanceMenu, 
		--> a hook for OnEnterScript
		OnEnterFunc = function() OnEnterMainWindow (instancia, baseframe.cabecalho.novo, 3) end,
		--> a hook for OnLeaveScript
		OnLeaveFunc = function() OnLeaveMainWindow (instancia, baseframe.cabecalho.novo, 3) end,
		--> default message if there is no option avaliable
		Default = Loc ["STRING_NOCLOSED_INSTANCES"], 
		--> instancia is the first parameter sent after click, before parameters
		FixedValue = instancia,
		Options = function()
			if (instancia.toolbar_side == 1) then --top
				return {TextSize = 10, NoLastSelectedBar = true}
			elseif (instancia.toolbar_side == 2) then --bottom
				return {HeightAnchorMod = -7, TextSize = 10, NoLastSelectedBar = true}
			end
		end
	}
	
	--> Inject
	_G.GameCooltip:CoolTipInject (baseframe.cabecalho.novo)
	
	--> RESETAR HISTORICO ----------------------------------------------------------------------------------------------------------------------------------------------------
	if (not _detalhes.ResetButton) then
	
		_detalhes.ResetButtonInstance = instancia.meu_id
		_detalhes.ResetButtonMode = 1
	
		function _detalhes:ResetButtonSnapTo (instancia)
			if (type (instancia) == "number") then
				instancia = _detalhes:GetInstance (instancia)
			end
			
			--print (instancia.baseframe, instancia.baseframe:GetObjectType())
			
			if (instancia.baseframe:GetWidth() < 215) then
				_detalhes.ResetButtonMode = 2
			else
				_detalhes.ResetButtonMode = 1
			end
			
			_detalhes.ResetButton:SetParent (instancia.baseframe)
			_detalhes.ResetButton2:SetParent (instancia.baseframe)
			_detalhes.ResetButton:SetPoint ("right", instancia.baseframe.cabecalho.novo, "left")
			_detalhes.ResetButton2:SetPoint ("right", instancia.baseframe.cabecalho.novo, "left", 3, 0)
			_detalhes.ResetButton:SetFrameLevel (instancia.baseframe.UPFrame:GetFrameLevel()+1)
			_detalhes.ResetButton2:SetFrameLevel (instancia.baseframe.UPFrame:GetFrameLevel()+1)
			
			if (_detalhes.ResetButtonMode == 1) then
				gump:Fade (_detalhes.ResetButton, 0)
				gump:Fade (_detalhes.ResetButton2, 1)
			else
				gump:Fade (_detalhes.ResetButton, 1)
				gump:Fade (_detalhes.ResetButton2, 0)
			end
			
		end
	
-----------------> big button
		_detalhes.ResetButton = CreateFrame ("button", "DetailsResetButton1", baseframe, "UIPanelButtonTemplate")
		_detalhes.ResetButton:SetFrameLevel (baseframe.UPFrame:GetFrameLevel()+1)
		_detalhes.ResetButton:SetWidth (50)
		_detalhes.ResetButton:SetHeight (12)
		_detalhes.ResetButton:SetPoint ("right", baseframe.cabecalho.novo, "left")
		
		_detalhes.ResetButton:SetText (Loc ["STRING_ERASE"])
		
		_detalhes.ResetButton:SetScript ("OnClick", function() _detalhes.tabela_historico:resetar() end)
		
		_detalhes.ResetButton:SetScript ("OnEnter", function (self) 
			local lower_instance = _detalhes:GetLowerInstanceNumber()
			if (lower_instance) then
				OnEnterMainWindow (_detalhes:GetInstance (lower_instance), self, 3)
			end
		end)
		
		_detalhes.ResetButton:SetScript ("OnLeave", function (self) 
		
			local lower_instance = _detalhes:GetLowerInstanceNumber()
			if (lower_instance) then
				OnLeaveMainWindow (_detalhes:GetInstance (lower_instance), self, 3)
			end

			if (_G.GameCooltip.active) then
				local passou = 0
				self:SetScript ("OnUpdate", function (self, elapsed)
					passou = passou+elapsed
					if (passou > 0.3) then
						if (not _G.GameCooltip.mouse_over and not _G.GameCooltip.button_over) then
							_G.GameCooltip:ShowMe (false)
						end
						self:SetScript ("OnUpdate", nil)
					end
				end)
			else
				self:SetScript ("OnUpdate", nil)
			end		
		end)	
		
----------------> small button
		_detalhes.ResetButton2 = CreateFrame ("button", "DetailsResetButton2", baseframe, "OptionsButtonTemplate")
		_detalhes.ResetButton2:SetFrameLevel (baseframe.UPFrame:GetFrameLevel()+1)
		_detalhes.ResetButton2:SetWidth (22)
		_detalhes.ResetButton2:SetHeight (15)
		_detalhes.ResetButton2:SetPoint ("right", baseframe.cabecalho.novo, "left", 2, 0)

		local text = _detalhes.ResetButton2:CreateFontString ("DetailsResetButton2Text2", "overlay", "GameFont_Gigantic")
		text:SetText ("-")
		_detalhes.ResetButton2:SetFontString (text)
		_detalhes.ResetButton2:SetNormalFontObject ("GameFont_Gigantic")
		_detalhes.ResetButton2:SetHighlightFontObject ("GameFont_Gigantic")
		
		_detalhes.ResetButton2:SetScript ("OnClick", function() _detalhes.tabela_historico:resetar() end)
		_detalhes.ResetButton2:SetScript ("OnEnter", function (self) 
			local lower_instance = _detalhes:GetLowerInstanceNumber()
			if (lower_instance) then
				OnEnterMainWindow (_detalhes:GetInstance (lower_instance), self, 3)
			end
		end)
		
		_detalhes.ResetButton2:SetScript ("OnLeave", function (self) 
		
			local lower_instance = _detalhes:GetLowerInstanceNumber()
			if (lower_instance) then
				OnLeaveMainWindow (_detalhes:GetInstance (lower_instance), self, 3)
			end
			
			if (_G.GameCooltip.active) then
				local passou = 0
				self:SetScript ("OnUpdate", function (self, elapsed)
					passou = passou+elapsed
					if (passou > 0.3) then
						if (not _G.GameCooltip.mouse_over and not _G.GameCooltip.button_over) then
							_G.GameCooltip:ShowMe (false)
						end
						self:SetScript ("OnUpdate", nil)
					end
				end)
			else
				self:SetScript ("OnUpdate", nil)
			end		
		end)	
	
	end
	
--> fim bot�o reset

--> Bot�o de Ajuda ----------------------------------------------------------------------------------------------------------------------------------------------------

	--> disabled
	if (instancia.meu_id == 1 and _detalhes.tutorial.logons < 0) then
	
		--> help button
		local helpButton = CreateFrame ("button", "DetailsMainWindowHelpButton", baseframe, "MainHelpPlateButton")
		helpButton:SetWidth (28)
		helpButton:SetHeight (28)
		helpButton.I:SetWidth (22)
		helpButton.I:SetHeight (22)
		helpButton.Ring:SetWidth (28)
		helpButton.Ring:SetHeight (28)
		helpButton.Ring:SetPoint ("center", 5, -6)
		
		helpButton:SetPoint ("topright", baseframe, "topleft", 37, 37)
		
		helpButton:SetFrameLevel (0)
		helpButton:SetFrameStrata ("LOW")

		local mainWindowHelp =  {
			FramePos = {x = 0, y = 10},
			FrameSize = {width = 300, height = 85},
			
			--> modo, segmento e atributo
			[1] ={HighLightBox = {x = 25, y = 10, width = 60, height = 20},
				ButtonPos = { x = 32, y = 40},
				ToolTipDir = "right",
				ToolTipText = Loc ["STRING_HELP_MENUS"]
			},
			--> delete
			[2] ={HighLightBox = {x = 195, y = 10, width = 47, height = 20},
				ButtonPos = { x = 197, y = 5},
				ToolTipDir = "left",
				ToolTipText = Loc ["STRING_HELP_ERASE"]
			},
			--> menu da instancia
			[3] ={HighLightBox = {x = 244, y = 10, width = 30, height = 20},
				ButtonPos = { x = 237, y = 5},
				ToolTipDir = "right",
				ToolTipText = Loc ["STRING_HELP_INSTANCE"]
			},
			--> stretch
			[4] ={HighLightBox = {x = 244, y = 30, width = 30, height = 20},
				ButtonPos = { x = 237, y = 57},
				ToolTipDir = "right",
				ToolTipText = Loc ["STRING_HELP_STRETCH"]
			},
			--> status bar
			[5] ={HighLightBox = {x = 0, y = -101, width = 300, height = 20},
				ButtonPos = { x = 126, y = -88},
				ToolTipDir = "left",
				ToolTipText = Loc ["STRING_HELP_STATUSBAR"]
			},
			--> switch menu
			[6] ={HighLightBox = {x = 0, y = -10, width = 300, height = 95},
				ButtonPos = { x = 127, y = -37},
				ToolTipDir = "left",
				ToolTipText = Loc ["STRING_HELP_SWITCH"]
			},
			--> resizer
			[7] ={HighLightBox = {x = 250, y = -81, width = 50, height = 20},
				ButtonPos = { x = 253, y = -52},
				ToolTipDir = "right",
				ToolTipText = Loc ["STRING_HELP_RESIZE"]
			},
		}
		
		helpButton:SetScript ("OnClick", function() 
			if (not HelpPlate_IsShowing (mainWindowHelp)) then
			
				instancia:SetSize (300, 95)
			
				HelpPlate_Show (mainWindowHelp, baseframe, helpButton, true)
			else
				HelpPlate_Hide (true)
			end
		end)
	
	end

---------> consolidate frame ----------------------------------------------------------------------------------------------------------------------------------------------------

	local consolidateFrame = CreateFrame ("frame", nil, _detalhes.listener)
	consolidateFrame:SetWidth (21)
	consolidateFrame:SetHeight (83)
	consolidateFrame:SetFrameLevel (baseframe:GetFrameLevel()-1)
	--consolidateFrame:SetPoint ("bottomleft", baseframe.cabecalho.ball, "bottomright", 0, 20)
	consolidateFrame:SetFrameStrata ("FULLSCREEN")
	consolidateFrame:Hide()
	instancia.consolidateFrame = consolidateFrame
	
---------> consolidate texture

	local frameTexture = consolidateFrame:CreateTexture (nil, "background")
	frameTexture:SetTexture ([[Interface\AddOns\Details\images\consolidate_frame]])
	frameTexture:SetPoint ("top", consolidateFrame, "top", .5, 0)
	frameTexture:SetWidth (32)
	frameTexture:SetHeight (83)
	frameTexture:SetTexCoord (0, 1, 0, 0.6484375)
	
---------> consolidate button

	local consolidateButton = CreateFrame ("button", nil, baseframe)
	consolidateButton:SetWidth (16)
	consolidateButton:SetHeight (16)
	consolidateButton:SetFrameLevel (baseframe.UPFrame:GetFrameLevel()+1)
	consolidateButton:SetPoint ("bottomleft", baseframe.cabecalho.ball, "bottomright", 6, 2)
	consolidateFrame:SetPoint ("bottom", consolidateButton, "top", 3, 0)

	local normal_texture = consolidateButton:CreateTexture (nil, "overlay")
	normal_texture:SetTexture ([[Interface\GossipFrame\HealerGossipIcon]])
	normal_texture:SetVertexColor (.9, .8, 0)
	normal_texture:SetWidth (16)
	normal_texture:SetHeight (16)
	normal_texture:SetPoint ("center", consolidateButton, "center")
	
	consolidateButton:Hide()
	instancia.consolidateButton = consolidateButton
	instancia.consolidateButtonTexture = normal_texture
	
---------> consolidate scripts

	consolidateFrame:SetScript ("OnEnter", function (self)
		consolidateFrame.mouse_over = true
		self:SetScript ("OnUpdate", nil)
	end) 

	consolidateFrame:SetScript ("OnLeave", function (self)
		consolidateFrame.mouse_over = false
		local passou = 0
		self:SetScript ("OnUpdate", function (self, elapsed)
			passou = passou+elapsed
			if (passou > 0.5) then
				if (not _G.GameCooltip.active and not baseframe.cabecalho.button_mouse_over) then
					consolidateFrame:Hide()
					normal_texture:SetBlendMode ("BLEND")
					self:SetScript ("OnUpdate", nil)
				end
				passou = 0
			end
		end)
	end) 
	
	consolidateButton:SetScript ("OnEnter", function (self)
		gump:Fade (baseframe.button_stretch, "alpha", 0.3)
		local passou = 0
		consolidateFrame:SetScript ("OnUpdate", nil)
		normal_texture:SetBlendMode ("ADD")
		self:SetScript ("OnUpdate", function (self, elapsed)
			passou = passou+elapsed
			if (passou > 0.3) then
				consolidateFrame:SetPoint ("bottom", self, "top", 3, 0)
				consolidateFrame:Show()
				self:SetScript ("OnUpdate", nil)
			end
		end)
	end)
	
	consolidateButton:SetScript ("OnLeave", function (self) 
		gump:Fade (baseframe.button_stretch, -1)
		local passou = 0
		self:SetScript ("OnUpdate", function (self, elapsed)
			passou = passou+elapsed
			if (passou > 0.3) then
				if (not consolidateFrame.mouse_over and not baseframe.cabecalho.button_mouse_over and not _G.GameCooltip.active) then
					consolidateFrame:Hide()
					normal_texture:SetBlendMode ("BLEND")
				end
				self:SetScript ("OnUpdate", nil)
			end
		end)
	end)
	
	
	
end
