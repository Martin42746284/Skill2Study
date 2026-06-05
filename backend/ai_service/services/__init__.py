"""Services du système IA"""

from .recommendation_engine import RecommendationEngine
from .scoring import ScoringEngine
from .knn_engine import KNNEngine
from .ml_models import MLModels

__all__ = [
    'RecommendationEngine',
    'ScoringEngine',
    'KNNEngine',
    'MLModels'
]
