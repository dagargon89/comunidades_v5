@props(['text', 'url'])

<a href="{{ $url }}"
   class="inline-flex items-center px-6 py-3 bg-amber-600 border border-transparent rounded-lg font-medium text-sm text-white shadow-sm hover:bg-amber-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-amber-500 transition-colors duration-200">
    {{ $text }}
    <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7l5 5m0 0l-5 5m5-5H6"></path>
    </svg>
</a>
