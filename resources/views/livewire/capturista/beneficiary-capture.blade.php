<div class="min-h-screen bg-gray-50">
    <!-- Navbar sin botón de login -->
    <x-layout.navbar :showLoginButton="false" />

    <!-- Contenido principal -->
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Header -->
        <div class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900">Captura de Beneficiarios</h1>
            <p class="text-gray-600">Registra beneficiarios para las actividades del Plan Estratégico</p>
        </div>

        <!-- Mensajes de notificación -->
        @if (session()->has('message'))
            <div class="mb-6">
                <div class="rounded-md p-4 {{ session('messageType') === 'success' ? 'bg-green-50 border border-green-200' : (session('messageType') === 'warning' ? 'bg-yellow-50 border border-yellow-200' : 'bg-red-50 border border-red-200') }}">
                    <div class="flex">
                        <div class="flex-shrink-0">
                            @if(session('messageType') === 'success')
                                <svg class="h-5 w-5 text-green-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                            @elseif(session('messageType') === 'warning')
                                <svg class="h-5 w-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                                </svg>
                            @else
                                <svg class="h-5 w-5 text-red-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                                </svg>
                            @endif
                        </div>
                        <div class="ml-3">
                            <p class="text-sm {{ session('messageType') === 'success' ? 'text-green-800' : (session('messageType') === 'warning' ? 'text-yellow-800' : 'text-red-800') }}">
                                {{ session('message') }}
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        @endif

        <!-- Formulario de selección de actividad -->
        <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 mb-8">
            <h2 class="text-lg font-semibold text-gray-900 mb-4">Información de Actividad</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label for="activity_id" class="block text-sm font-medium text-gray-700 mb-2">
                        Actividad
                    </label>
                    <select wire:model.live="activity_id" id="activity_id" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                        <option value="">Selecciona una actividad</option>
                        @foreach($activities as $id => $name)
                            <option value="{{ $id }}">{{ $name }}</option>
                        @endforeach
                    </select>
                </div>

                <div>
                    <label for="activity_calendar_id" class="block text-sm font-medium text-gray-700 mb-2">
                        Fecha y Hora de la Actividad
                    </label>
                    <select wire:model.live="activity_calendar_id" id="activity_calendar_id" class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500" {{ empty($activityCalendars) ? 'disabled' : '' }}>
                        <option value="">Selecciona una fecha</option>
                        @foreach($activityCalendars as $id => $label)
                            <option value="{{ $id }}">{{ $label }}</option>
                        @endforeach
                    </select>
                    @if($calendarCount > 0)
                        <p class="text-sm text-gray-500 mt-1">Esta actividad tiene {{ $calendarCount }} fecha(s) programada(s)</p>
                    @elseif($activity_id)
                        <p class="text-sm text-red-500 mt-1">Esta actividad no tiene fechas y horarios programados</p>
                    @endif
                </div>
            </div>

            @if($activityInfo)
                <div class="mt-6 p-4 bg-amber-50 border border-amber-200 rounded-md">
                    <h3 class="text-sm font-medium text-amber-800 mb-2">Información de la Actividad Seleccionada:</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                        <div>
                            <span class="font-medium text-amber-800">Actividad:</span> {{ $activityInfo['actividad'] }}
                        </div>
                        <div>
                            <span class="font-medium text-amber-800">Fecha:</span> {{ $activityInfo['fecha'] }}
                        </div>
                        <div>
                            <span class="font-medium text-amber-800">Hora:</span> {{ $activityInfo['hora_inicio'] }} - {{ $activityInfo['hora_fin'] }}
                        </div>
                        <div>
                            <span class="font-medium text-amber-800">Responsable:</span> {{ $activityInfo['responsable'] }}
                        </div>
                    </div>
                </div>
            @endif
        </div>

        <!-- Botones de acción -->
        @if($activity_calendar_id)
            <div class="mb-6 flex flex-wrap gap-4">
                <button wire:click="showSingleForm" class="inline-flex items-center px-4 py-2 bg-amber-600 border border-transparent rounded-lg font-medium text-sm text-white shadow-sm hover:bg-amber-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500 transition-colors duration-200">
                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                    </svg>
                    Registrar Beneficiario Único
                </button>

                <button wire:click="showMassiveForm" class="inline-flex items-center px-4 py-2 bg-green-600 border border-transparent rounded-lg font-medium text-sm text-white shadow-sm hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors duration-200">
                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                    </svg>
                    Registro Masivo
                </button>
            </div>
        @endif

        <!-- Formulario de registro único -->
        @if($showSingleForm)
            <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 mb-8">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-lg font-semibold text-gray-900">Registrar Beneficiario Único</h3>
                    <button wire:click="cancelForm" class="text-gray-400 hover:text-gray-600">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>

                <form wire:submit.prevent="saveSingleBeneficiary">
                    <!-- Búsqueda de beneficiario -->
                    <div class="mb-6 p-4 bg-gray-50 border border-gray-200 rounded-md">
                        <h4 class="text-sm font-medium text-gray-700 mb-3">Búsqueda de Beneficiario</h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label for="search_identifier" class="block text-sm font-medium text-gray-700 mb-1">
                                    Buscar por identificador
                                </label>
                                <input type="text" wire:model.live="search_identifier" id="search_identifier"
                                       class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500"
                                       placeholder="Ej: PEREZ2025M">
                                <p class="text-xs text-gray-500 mt-1">Ingresa el identificador para buscar un beneficiario existente</p>
                            </div>
                        </div>
                    </div>

                    <!-- Datos personales -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <div>
                            <label for="last_name" class="block text-sm font-medium text-gray-700 mb-1">
                                Apellido Paterno *
                            </label>
                            <input type="text" wire:model="last_name" id="last_name" required
                                   class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                            @error('last_name') <span class="text-red-500 text-sm">{{ $message }}</span> @enderror
                        </div>

                        <div>
                            <label for="mother_last_name" class="block text-sm font-medium text-gray-700 mb-1">
                                Apellido Materno *
                            </label>
                            <input type="text" wire:model="mother_last_name" id="mother_last_name" required
                                   class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                            @error('mother_last_name') <span class="text-red-500 text-sm">{{ $message }}</span> @enderror
                        </div>

                        <div class="md:col-span-2">
                            <label for="first_names" class="block text-sm font-medium text-gray-700 mb-1">
                                Nombres *
                            </label>
                            <input type="text" wire:model="first_names" id="first_names" required
                                   class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                            @error('first_names') <span class="text-red-500 text-sm">{{ $message }}</span> @enderror
                        </div>

                        <div>
                            <label for="birth_year" class="block text-sm font-medium text-gray-700 mb-1">
                                Año de Nacimiento *
                            </label>
                            <input type="text" wire:model="birth_year" id="birth_year" required maxlength="4"
                                   class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                            @error('birth_year') <span class="text-red-500 text-sm">{{ $message }}</span> @enderror
                        </div>

                        <div>
                            <label for="gender" class="block text-sm font-medium text-gray-700 mb-1">
                                Género *
                            </label>
                            <select wire:model="gender" id="gender" required
                                    class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                                <option value="">Selecciona</option>
                                <option value="M">Masculino</option>
                                <option value="F">Femenino</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select>
                            @error('gender') <span class="text-red-500 text-sm">{{ $message }}</span> @enderror
                        </div>

                        <div>
                            <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">
                                Teléfono
                            </label>
                            <input type="text" wire:model="phone" id="phone"
                                   class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                            @error('phone') <span class="text-red-500 text-sm">{{ $message }}</span> @enderror
                        </div>

                        <div class="md:col-span-2">
                            <label for="address_backup" class="block text-sm font-medium text-gray-700 mb-1">
                                Dirección de Respaldo
                            </label>
                            <textarea wire:model="address_backup" id="address_backup" rows="3"
                                      class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500"></textarea>
                            @error('address_backup') <span class="text-red-500 text-sm">{{ $message }}</span> @enderror
                        </div>
                    </div>

                    <!-- Firma -->
                    <div class="mb-6">
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                            Firma del Beneficiario *
                        </label>
                        <div class="border-2 border-dashed border-gray-300 rounded-lg p-4 text-center">
                            <p class="text-gray-500">Componente de firma aquí</p>
                            <!-- Aquí iría el componente de firma -->
                        </div>
                        @error('signature') <span class="text-red-500 text-sm">{{ $message }}</span> @enderror
                    </div>

                    <!-- Botones -->
                    <div class="flex justify-end space-x-4">
                        <button type="button" wire:click="cancelForm"
                                class="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500">
                            Cancelar
                        </button>
                        <button type="submit"
                                class="px-4 py-2 bg-amber-600 border border-transparent rounded-md text-sm font-medium text-white hover:bg-amber-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500">
                            Guardar Beneficiario
                        </button>
                    </div>
                </form>
            </div>
        @endif

        <!-- Formulario de registro masivo -->
        @if($showMassiveForm)
            <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 mb-8">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-lg font-semibold text-gray-900">Registro Masivo de Beneficiarios</h3>
                    <button wire:click="cancelForm" class="text-gray-400 hover:text-gray-600">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>

                <form wire:submit.prevent="saveMassiveBeneficiaries">
                    <div class="space-y-4">
                        @foreach($beneficiarios as $index => $beneficiario)
                            <div class="border border-gray-200 rounded-lg p-4">
                                <div class="flex justify-between items-center mb-4">
                                    <h4 class="text-sm font-medium text-gray-700">Beneficiario {{ $index + 1 }}</h4>
                                    @if(count($beneficiarios) > 1)
                                        <button type="button" wire:click="removeBeneficiaryRow({{ $index }})"
                                                class="text-red-500 hover:text-red-700">
                                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                            </svg>
                                        </button>
                                    @endif
                                </div>

                                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Identificador</label>
                                        <input type="text" wire:model="beneficiarios.{{ $index }}.search_identifier"
                                               class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500"
                                               placeholder="Ej: PEREZ2025M">
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Apellido Paterno *</label>
                                        <input type="text" wire:model="beneficiarios.{{ $index }}.last_name" required
                                               class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Apellido Materno *</label>
                                        <input type="text" wire:model="beneficiarios.{{ $index }}.mother_last_name" required
                                               class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Nombres *</label>
                                        <input type="text" wire:model="beneficiarios.{{ $index }}.first_names" required
                                               class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Año Nacimiento *</label>
                                        <input type="text" wire:model="beneficiarios.{{ $index }}.birth_year" required maxlength="4"
                                               class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Género *</label>
                                        <select wire:model="beneficiarios.{{ $index }}.gender" required
                                                class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                                            <option value="">Selecciona</option>
                                            <option value="M">Masculino</option>
                                            <option value="F">Femenino</option>
                                        </select>
                                    </div>

                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Teléfono</label>
                                        <input type="text" wire:model="beneficiarios.{{ $index }}.phone"
                                               class="w-full border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                                    </div>

                                    <div class="md:col-span-2">
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Firma *</label>
                                        <div class="border-2 border-dashed border-gray-300 rounded-lg p-4 text-center">
                                            <p class="text-gray-500">Componente de firma aquí</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </div>

                    <div class="mt-6 flex justify-between">
                        <button type="button" wire:click="addBeneficiaryRow"
                                class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                            </svg>
                            Agregar Otro Beneficiario
                        </button>

                        <div class="flex space-x-4">
                            <button type="button" wire:click="cancelForm"
                                    class="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500">
                                Cancelar
                            </button>
                            <button type="submit"
                                    class="px-4 py-2 bg-amber-600 border border-transparent rounded-md text-sm font-medium text-white hover:bg-amber-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500">
                                Guardar Todos
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        @endif

        <!-- Tabla de beneficiarios registrados -->
        @if($activity_calendar_id)
            <div class="bg-white rounded-lg shadow-sm border border-gray-200">
                <div class="px-6 py-4 border-b border-gray-200">
                    <div class="flex justify-between items-center">
                        <h3 class="text-lg font-semibold text-gray-900">Beneficiarios Registrados</h3>

                        <!-- Filtros -->
                        <div class="flex items-center space-x-4">
                            <!-- Búsqueda general -->
                            <div class="relative">
                                <input type="text"
                                       wire:model.live="search"
                                       placeholder="Buscar beneficiarios..."
                                       class="w-64 px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                                <svg class="absolute right-3 top-2.5 w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                                </svg>
                            </div>

                            <!-- Filtro por género -->
                            <select wire:model.live="filterGender" class="px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                                <option value="">Todos los géneros</option>
                                <option value="M">Masculino</option>
                                <option value="F">Femenino</option>
                            </select>

                            <!-- Filtro por año -->
                            <select wire:model.live="filterYear" class="px-3 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-amber-500 focus:border-amber-500">
                                <option value="">Todos los años</option>
                                @for($year = date('Y'); $year >= 1900; $year--)
                                    <option value="{{ $year }}">{{ $year }}</option>
                                @endfor
                            </select>

                            <!-- Botón limpiar filtros -->
                            <button wire:click="clearFilters"
                                    class="px-3 py-2 text-sm text-gray-600 hover:text-gray-800 hover:bg-gray-100 rounded-md transition-colors duration-200">
                                Limpiar Filtros
                            </button>
                        </div>
                    </div>
                </div>

                @if($beneficiaries->count() > 0)

                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    <button wire:click="sortBy('identifier')" class="flex items-center space-x-1 hover:text-amber-600 transition-colors duration-200">
                                        <span>Identificador</span>
                                        @if($sortField === 'identifier')
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                @if($sortDirection === 'asc')
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path>
                                                @else
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                                @endif
                                            </svg>
                                        @endif
                                    </button>
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    <button wire:click="sortBy('last_name')" class="flex items-center space-x-1 hover:text-amber-600 transition-colors duration-200">
                                        <span>Apellido Paterno</span>
                                        @if($sortField === 'last_name')
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                @if($sortDirection === 'asc')
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path>
                                                @else
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                                @endif
                                            </svg>
                                        @endif
                                    </button>
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Apellido Materno
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    <button wire:click="sortBy('first_names')" class="flex items-center space-x-1 hover:text-amber-600 transition-colors duration-200">
                                        <span>Nombres</span>
                                        @if($sortField === 'first_names')
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                @if($sortDirection === 'asc')
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path>
                                                @else
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                                @endif
                                            </svg>
                                        @endif
                                    </button>
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    <button wire:click="sortBy('birth_year')" class="flex items-center space-x-1 hover:text-amber-600 transition-colors duration-200">
                                        <span>Año Nacimiento</span>
                                        @if($sortField === 'birth_year')
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                @if($sortDirection === 'asc')
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path>
                                                @else
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                                @endif
                                            </svg>
                                        @endif
                                    </button>
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    <button wire:click="sortBy('gender')" class="flex items-center space-x-1 hover:text-amber-600 transition-colors duration-200">
                                        <span>Género</span>
                                        @if($sortField === 'gender')
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                @if($sortDirection === 'asc')
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path>
                                                @else
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                                @endif
                                            </svg>
                                        @endif
                                    </button>
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Teléfono
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Firma
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    <button wire:click="sortBy('created_at')" class="flex items-center space-x-1 hover:text-amber-600 transition-colors duration-200">
                                        <span>Registrado el</span>
                                        @if($sortField === 'created_at')
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                @if($sortDirection === 'asc')
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path>
                                                @else
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                                                @endif
                                            </svg>
                                        @endif
                                    </button>
                                </th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                    Acciones
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            @foreach($beneficiaries as $registry)
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <span class="font-medium text-amber-600">{{ $registry->beneficiaries->identifier ?? '-' }}</span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        {{ $registry->beneficiaries->last_name ?? '-' }}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        {{ $registry->beneficiaries->mother_last_name ?? '-' }}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        {{ $registry->beneficiaries->first_names ?? '-' }}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        {{ $registry->beneficiaries->birth_year ?? '-' }}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        @switch($registry->beneficiaries->gender)
                                            @case('M')
                                                Masculino
                                                @break
                                            @case('F')
                                                Femenino
                                                @break
                                            @case('Male')
                                                Male
                                                @break
                                            @case('Female')
                                                Female
                                                @break
                                            @default
                                                {{ $registry->beneficiaries->gender ?? '-' }}
                                        @endswitch
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        {{ $registry->beneficiaries->phone ?? '-' }}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        @if($registry->signature)
                                            <div class="w-32 h-16 bg-gray-100 border border-gray-300 rounded flex items-center justify-center">
                                                <span class="text-xs text-gray-500">Firma</span>
                                            </div>
                                        @else
                                            <span class="text-gray-400">Sin firma</span>
                                        @endif
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        {{ $registry->created_at ? $registry->created_at->format('d/m/Y H:i') : '-' }}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <button wire:click="deleteBeneficiary({{ $registry->id }})"
                                                onclick="return confirm('¿Estás seguro de que quieres eliminar este registro?')"
                                                class="text-red-600 hover:text-red-900">
                                            Eliminar
                                        </button>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <div class="px-6 py-4 border-t border-gray-200">
                    {{ $beneficiaries->links() }}
                </div>
                @else
                <!-- Mensaje cuando no hay resultados pero hay filtros aplicados -->
                <div class="p-8 text-center">
                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
                    </svg>
                    <h3 class="mt-2 text-sm font-medium text-gray-900">No se encontraron beneficiarios</h3>
                    <p class="mt-1 text-sm text-gray-500">
                        @if(!empty($search) || !empty($filterGender) || !empty($filterYear))
                            No hay resultados que coincidan con los filtros aplicados.
                            <button wire:click="clearFilters" class="text-amber-600 hover:text-amber-700 underline">
                                Limpiar filtros
                            </button>
                        @else
                            No hay beneficiarios registrados para esta actividad.
                        @endif
                    </p>
                </div>
                @endif
            </div>
        @elseif($activity_calendar_id)
            <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-8 text-center">
                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                </svg>
                <h3 class="mt-2 text-sm font-medium text-gray-900">No hay beneficiarios registrados</h3>
                <p class="mt-1 text-sm text-gray-500">Comienza registrando el primer beneficiario para esta actividad.</p>
            </div>
        @endif
    </main>
</div>
